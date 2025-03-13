package com.shop.swp391.controller.dashboard.marketing;

import com.shop.swp391.dal.BlogDAO;
import com.shop.swp391.dal.BlogCategoryDAO;
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
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "PostController", urlPatterns = {"/post-manage"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class PostController extends HttpServlet {

    private BlogDAO blogDAO;
    private BlogCategoryDAO blogCategoryDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        blogDAO = new BlogDAO();
        blogCategoryDAO = new BlogCategoryDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "create":
                showCreateForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "view":
                viewBlog(request, response);
                break;
            case "delete":
                deleteBlog(request, response);
                break;
            default:
                listBlogs(request, response);
                break;
        }
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<BlogCategory> categories = blogCategoryDAO.findAll();
        List<User> users = userDAO.findAll();
        request.setAttribute("categories", categories);
        request.setAttribute("users", users);
        request.getRequestDispatcher("view/marketing/add-blog.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Blog blog = blogDAO.findById(id);
        if (blog != null) {
            List<BlogCategory> categories = blogCategoryDAO.findAll();
            List<User> users = userDAO.findAll();
            request.setAttribute("categories", categories);
            request.setAttribute("users", users);
            request.setAttribute("blog", blog);
            request.getRequestDispatcher("view/marketing/blogform.jsp").forward(request, response);
        } else {
            response.sendRedirect("post-manage?action=list&error=postNotFound");
        }
    }

    private void viewBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Blog blog = blogDAO.findById(id);
        if (blog != null) {
            request.setAttribute("blog", blog);
            request.getRequestDispatcher("view/marketing/postdetail.jsp").forward(request, response);
        } else {
            response.sendRedirect("post-manage?action=list&error=postNotFound");
        }
    }

    private void listBlogs(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Blog> blogs = blogDAO.findAll();
        request.setAttribute("blogs", blogs);
        request.getRequestDispatcher("view/marketing/postlist.jsp").forward(request, response);
    }

    private void deleteBlog(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Blog blog = new Blog();
        blog.setId(id);
        blogDAO.delete(blog);
        response.sendRedirect("post-manage?action=list&success=postDeleted");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("create".equals(action)) {
            createBlog(request, response);
        } else if ("update".equals(action)) {
            updateBlog(request, response);
        } else {
            response.sendRedirect("post-manage?action=list");
        }
    }

    private void createBlog(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String brief = request.getParameter("brief");
            Part imagePart = request.getPart("image");
            String image = (imagePart != null && imagePart.getSize() > 0) ? imagePart.getSubmittedFileName() : null;
            int authorId = Integer.parseInt(request.getParameter("author"));
            int categoryId = Integer.parseInt(request.getParameter("category"));
            String status = request.getParameter("status");
            if (status == null || status.trim().isEmpty()) {
                status = "Active";
            }

            Blog newBlog = new Blog();
            newBlog.setTitle(title);
            newBlog.setContent(content);
            newBlog.setBriefInfo(brief);
            newBlog.setThumbnail(image);
            newBlog.setAuthor(authorId);
            newBlog.setCategoryId(categoryId);
            newBlog.setStatus(status);

            blogDAO.insert(newBlog);
            response.sendRedirect("post-manage?action=list&success=postCreated");
        } catch (Exception e) {
            response.sendRedirect("post-manage?action=create&error=true");
        }
    }

    private void updateBlog(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String brief = request.getParameter("brief");
            String image = request.getParameter("image");
            int categoryId = Integer.parseInt(request.getParameter("category"));
            int authorId = Integer.parseInt(request.getParameter("author"));
            String status = request.getParameter("status");
            if (status == null || status.trim().isEmpty()) {
                status = "Active";
            }

            Blog blog = Blog.builder()
                    .id(id)
                    .title(title)
                    .content(content)
                    .briefInfo(brief)
                    .thumbnail(image)
                    .author(authorId)
                    .categoryId(categoryId)
                    .status(status)
                    .build();
            blogDAO.update(blog);
        } catch (NumberFormatException e) {
            
        }
        response.sendRedirect("post-manage?action=list");
    }
}
