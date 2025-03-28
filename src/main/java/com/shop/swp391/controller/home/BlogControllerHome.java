package com.shop.swp391.controller.home;

import com.shop.swp391.dal.BlogDAO;
import com.shop.swp391.dal.BlogCategoryDAO;
import com.shop.swp391.dal.UserDAO;
import com.shop.swp391.entity.Blog;
import com.shop.swp391.entity.BlogCategory;
import com.shop.swp391.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "BlogControllerHome", urlPatterns = {"/blogs"})
public class BlogControllerHome extends HttpServlet {
    
    private final BlogDAO blogDAO = new BlogDAO();
    private final BlogCategoryDAO blogCategoryDAO = new BlogCategoryDAO();
    private final UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null || action.isEmpty() || action.equals("list")) {
            // Handle list with filters action
            handleListWithFilters(request, response);
        } else if (action.equals("view")) {
            // Handle view single blog action
            viewBlogDetails(request, response);
        } else {
            // Default to list action
            handleListWithFilters(request, response);
        } 
    }
    
    private void handleListWithFilters(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get filter parameters
        String searchFilter = request.getParameter("search");
        String categoryIdParam = request.getParameter("category");
        
        // Parse category ID
        Integer categoryId = null;
        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdParam);
            } catch (NumberFormatException e) {
                // Invalid category ID, ignore it
                categoryId = null;
            }
        }
        
        // Get pagination parameters
        int page = 1;
        int pageSize = 6; // Number of blogs per page
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
        
        // Only show active blogs on the public site
        String statusFilter = "Active";
        
        // Get blogs with pagination and filters - using a default value of 0 when categoryId is null
        List<Blog> blogs = blogDAO.findBlogsWithFilters(searchFilter, statusFilter, categoryId, page, pageSize);
        
        // Get total count of filtered blogs
        int totalBlogs = blogDAO.getTotalFilteredBlogs(searchFilter, statusFilter, categoryId);
        int totalPages = (int) Math.ceil((double) totalBlogs / pageSize);
        
        // Get all categories for filter dropdown
        List<BlogCategory> categories = blogCategoryDAO.findAll();
        
        // Get all users for author mapping
        List<User> users = userDAO.findAll();
        Map<Integer, User> userMap = new HashMap<>();
        for (User user : users) {
            userMap.put(user.getId(), user);
        }
        
        // Build pagination URL
        String paginationUrl = buildPaginationUrl(request);
        
        // Set attributes for JSP
        request.setAttribute("blogs", blogs);
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalBlogs", totalBlogs);
        request.setAttribute("userMap", userMap);
        request.setAttribute("paginationUrl", paginationUrl);
        request.setAttribute("searchFilter", searchFilter);
        request.setAttribute("categoryFilter", categoryId);
        
        // Forward to the blog list JSP
        request.getRequestDispatcher("view/blog/blog.jsp").forward(request, response);
    }
    
    private void viewBlogDetails(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String blogIdParam = request.getParameter("id");
        
        if (blogIdParam != null && !blogIdParam.isEmpty()) {
            try {
                int blogId = Integer.parseInt(blogIdParam);
                Blog blog = blogDAO.findById(blogId);
                
                if (blog != null && blog.getStatus().equals("Active")) {
                    // Get blog category
                    BlogCategory category = blogCategoryDAO.findById(blog.getCategoryId());
                    
                    // Get author information
                    User author = userDAO.findById(blog.getAuthor());
                    
                    // Get related blogs (same category, excluding current blog)
                    List<Blog> relatedBlogs = blogDAO.findRelatedBlogs(blogId, blog.getCategoryId(), 3);
                    
                    // Set attributes for JSP
                    request.setAttribute("blog", blog);
                    request.setAttribute("category", category);
                    request.setAttribute("author", author);
                    request.setAttribute("relatedBlogs", relatedBlogs);
                    
                    // Forward to the blog details JSP
                    request.getRequestDispatcher("view/blog/blog-details.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // Invalid blog ID, redirect to blog list
            }
        }
        
        // Blog not found or invalid ID, redirect to blog list
        response.sendRedirect(request.getContextPath() + "/blogs");
    }
    
    /**
     * Builds the pagination URL maintaining all current query parameters except page
     * @param request The HTTP request
     * @return URL string with query parameters
     */
    private String buildPaginationUrl(HttpServletRequest request) {
        StringBuilder url = new StringBuilder("blogs?");
        Map<String, String[]> parameters = request.getParameterMap();
        boolean firstParam = true;
        
        for (Map.Entry<String, String[]> entry : parameters.entrySet()) {
            String paramName = entry.getKey();
            String[] paramValues = entry.getValue();
            
            // Skip the page parameter, as it will be added in the pagination links
            if ("page".equals(paramName)) {
                continue;
            }
            
            for (String paramValue : paramValues) {
                if (!firstParam) {
                    url.append("&");
                } else {
                    firstParam = false;
                }
                url.append(paramName).append("=").append(paramValue);
            }
        }
        
        if (!firstParam) {
            url.append("&");
        }
        
        return url.toString();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Just redirect to doGet for now
        doGet(request, response);
    }
}
