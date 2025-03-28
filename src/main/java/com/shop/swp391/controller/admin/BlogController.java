package com.shop.swp391.controller.admin;

import com.shop.swp391.dal.BlogCategoryDAO;
import com.shop.swp391.dal.BlogDAO;
import com.shop.swp391.dal.UserDAO;
import com.shop.swp391.entity.Blog;
import com.shop.swp391.entity.BlogCategory;
import com.shop.swp391.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
@WebServlet(name = "BlogController", urlPatterns = {"/manage-blog"})
public class BlogController extends HttpServlet {

    private final BlogDAO blogDAO = new BlogDAO();
    private final BlogCategoryDAO blogCategoryDAO = new BlogCategoryDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.equals("list")) {
            handleListWithFilters(request, response);
        } else {
            switch (action) {
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteBlog(request, response);
                    break;
                case "deactivate":
                    deactivateBlog(request, response);
                    break;
                case "activate":
                    activateBlog(request, response);
                    break;
                default:
                    handleListWithFilters(request, response);
                    break;
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Default action
        }
        switch (action) {
            case "add":
                addBlog(request, response);
                break;
            case "update":
                updateBlog(request, response);
                break;
            default:
                handleListWithFilters(request, response);
                break;
        }
    }

    private void handleListWithFilters(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get filter parameters
        String searchFilter = request.getParameter("search");
        String statusFilter = request.getParameter("status");
        String categoryFilter = request.getParameter("category");

        Integer categoryId = null;
        if (categoryFilter != null && !categoryFilter.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryFilter);
            } catch (NumberFormatException e) {
                categoryId = null;
            }
        }

        // Get pagination parameters
        int page = 1;
        int pageSize = 10;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        // Get blogs with pagination and filters
        List<Blog> blogs = blogDAO.findBlogsWithFilters(searchFilter, statusFilter, categoryId, page, pageSize);
        
        // Get total count of filtered blogs
        int totalBlogs = blogDAO.getTotalFilteredBlogs(searchFilter, statusFilter, categoryId);
        int totalPages = (int) Math.ceil((double) totalBlogs / pageSize);

        // Get all categories for filter dropdown
        List<BlogCategory> categories = blogCategoryDAO.findAll();
        
        // Get all users for author mapping
        List<User> users = userDAO.findAll();
        Map<Integer, User> userMap = users.stream()
                .collect(Collectors.toMap(User::getId, item -> item));

        // Set attributes
        request.setAttribute("blogs", blogs);
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalBlogs", totalBlogs);
        request.setAttribute("userMap", userMap);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("searchFilter", searchFilter);
        request.setAttribute("categoryFilter", categoryId);

        request.getRequestDispatcher("view/dashboard/admin/blog_list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<BlogCategory> categories = blogCategoryDAO.findAll();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("view/dashboard/admin/blog_add.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String blogIdStr = request.getParameter("id");
        if (blogIdStr != null && !blogIdStr.isEmpty()) {
            try {
                int blogId = Integer.parseInt(blogIdStr);
                Blog blog = blogDAO.findById(blogId);
                if (blog != null) {
                    List<BlogCategory> categories = blogCategoryDAO.findAll();
                    request.setAttribute("blog", blog);
                    request.setAttribute("categories", categories);
                    request.getRequestDispatcher("view/dashboard/admin/blog_details.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // Invalid ID format
            }
        }
        response.sendRedirect(request.getContextPath() + "/manage-blog");
    }

    private void addBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        try {
            String title = request.getParameter("title");
            String briefInfo = request.getParameter("briefInfo");
            String content = request.getParameter("content");
            String status = request.getParameter("status");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));

            // Handle thumbnail upload
            Part filePart = request.getPart("thumbnail");
            String fileName = null;
            
            if (filePart != null && filePart.getSize() > 0) {
                fileName = System.currentTimeMillis() + "_" + getFileName(filePart);
                String uploadPath = request.getServletContext().getRealPath("") + "assets/images/blog";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                filePart.write(uploadPath + File.separator + fileName);
            }

            // Create blog object
            Blog blog = new Blog();
            blog.setTitle(title);
            blog.setBriefInfo(briefInfo);
            blog.setContent(content);
            blog.setStatus(status);
            blog.setCategoryId(categoryId);
            blog.setThumbnail(fileName != null ? "assets/images/blog/" + fileName : null);
            
            // Set author as current user if authenticated, otherwise use default author
            if (user != null) {
                blog.setAuthor(user.getId());
            } else {
                blog.setAuthor(1); // Default author ID
            }

            int result = blogDAO.insert(blog);
            if (result > 0) {
                session.setAttribute("toastMessage", "Blog added successfully!");
                session.setAttribute("toastType", "success");
            } else {
                session.setAttribute("toastMessage", "Failed to add blog!");
                session.setAttribute("toastType", "error");
            }
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Error: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }
        
        response.sendRedirect(request.getContextPath() + "/manage-blog");
    }

    private void updateBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        try {
            int blogId = Integer.parseInt(request.getParameter("id"));
            Blog blog = blogDAO.findById(blogId);
            
            if (blog != null) {
                String title = request.getParameter("title");
                String briefInfo = request.getParameter("briefInfo");
                String content = request.getParameter("content");
                String status = request.getParameter("status");
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));

                // Handle thumbnail upload
                Part filePart = request.getPart("thumbnail");
                if (filePart != null && filePart.getSize() > 0) {
                    // Delete old thumbnail if it exists
                    if (blog.getThumbnail() != null && !blog.getThumbnail().isEmpty()) {
                        String oldThumbnailPath = request.getServletContext().getRealPath("") + blog.getThumbnail();
                        File oldThumbnail = new File(oldThumbnailPath);
                        if (oldThumbnail.exists()) {
                            oldThumbnail.delete();
                        }
                    }

                    // Save new thumbnail
                    String fileName = System.currentTimeMillis() + "_" + getFileName(filePart);
                    String uploadPath = request.getServletContext().getRealPath("") + "assets/images/blog";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    filePart.write(uploadPath + File.separator + fileName);
                    blog.setThumbnail("assets/images/blog/" + fileName);
                }

                blog.setTitle(title);
                blog.setBriefInfo(briefInfo);
                blog.setContent(content);
                blog.setStatus(status);
                blog.setCategoryId(categoryId);
                blog.setUpdatedDate(LocalDateTime.now());

                boolean result = blogDAO.update(blog);
                if (result) {
                    session.setAttribute("toastMessage", "Blog updated successfully!");
                    session.setAttribute("toastType", "success");
                } else {
                    session.setAttribute("toastMessage", "Failed to update blog!");
                    session.setAttribute("toastType", "error");
                }
            } else {
                session.setAttribute("toastMessage", "Blog not found!");
                session.setAttribute("toastType", "error");
            }
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Error: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }
        
        response.sendRedirect(request.getContextPath() + "/manage-blog");
    }

    private void deleteBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        try {
            int blogId = Integer.parseInt(request.getParameter("id"));
            Blog blog = blogDAO.findById(blogId);
            
            if (blog != null) {
                // Delete thumbnail if it exists
                if (blog.getThumbnail() != null && !blog.getThumbnail().isEmpty()) {
                    String thumbnailPath = request.getServletContext().getRealPath("") + blog.getThumbnail();
                    File thumbnailFile = new File(thumbnailPath);
                    if (thumbnailFile.exists()) {
                        thumbnailFile.delete();
                    }
                }
                
                boolean result = blogDAO.delete(blog);
                if (result) {
                    session.setAttribute("toastMessage", "Blog deleted successfully!");
                    session.setAttribute("toastType", "success");
                } else {
                    session.setAttribute("toastMessage", "Failed to delete blog!");
                    session.setAttribute("toastType", "error");
                }
            } else {
                session.setAttribute("toastMessage", "Blog not found!");
                session.setAttribute("toastType", "error");
            }
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Error: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }
        
        response.sendRedirect(request.getContextPath() + "/manage-blog");
    }

    private void deactivateBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        try {
            int blogId = Integer.parseInt(request.getParameter("id"));
            Blog blog = blogDAO.findById(blogId);
            
            if (blog != null) {
                blog.setStatus("Inactive");
                boolean result = blogDAO.update(blog);
                if (result) {
                    session.setAttribute("toastMessage", "Blog deactivated successfully!");
                    session.setAttribute("toastType", "success");
                } else {
                    session.setAttribute("toastMessage", "Failed to deactivate blog!");
                    session.setAttribute("toastType", "error");
                }
            } else {
                session.setAttribute("toastMessage", "Blog not found!");
                session.setAttribute("toastType", "error");
            }
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Error: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }
        
        response.sendRedirect(request.getContextPath() + "/manage-blog");
    }
    
    private void activateBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        try {
            int blogId = Integer.parseInt(request.getParameter("id"));
            Blog blog = blogDAO.findById(blogId);
            
            if (blog != null) {
                blog.setStatus("Active");
                boolean result = blogDAO.update(blog);
                if (result) {
                    session.setAttribute("toastMessage", "Blog activated successfully!");
                    session.setAttribute("toastType", "success");
                } else {
                    session.setAttribute("toastMessage", "Failed to activate blog!");
                    session.setAttribute("toastType", "error");
                }
            } else {
                session.setAttribute("toastMessage", "Blog not found!");
                session.setAttribute("toastType", "error");
            }
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Error: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }
        
        response.sendRedirect(request.getContextPath() + "/manage-blog");
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] elements = contentDisposition.split(";");
        
        for (String element : elements) {
            if (element.trim().startsWith("filename")) {
                return element.substring(element.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        
        return "unnamed_file";
    }
} 