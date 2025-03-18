package com.shop.swp391.controller.blog;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import com.shop.swp391.dal.BlogDAO;
import com.shop.swp391.entity.Blog;

@WebServlet(name = "ManageBlogController", urlPatterns = {"/blog"})
public class ManageBlogController extends HttpServlet {
    private BlogDAO blogDAO;

    @Override
    public void init() throws ServletException {
        blogDAO = new BlogDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "view":
                viewBlog(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            default:
                listBlogs(request, response);
                break;
        }
    }

    private void listBlogs(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Blog> blogs = blogDAO.findAll();
        request.setAttribute("blogs", blogs);
        request.getRequestDispatcher("view/blog/blog.jsp").forward(request, response);
    }

    private void viewBlog(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Blog blog = blogDAO.findById(id);
        request.setAttribute("blog", blog);
        request.getRequestDispatcher("view/blog/blog-details.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Blog blog = blogDAO.findById(id);
        request.setAttribute("blog", blog);
        request.getRequestDispatcher("blog-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "save";
        }
        switch (action) {
            case "update":
                updateBlog(request, response);
                break;
            case "delete":
                deleteBlog(request, response);
                break;
            default:
                createBlog(request, response);
                break;
        }
    }

    private void createBlog(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        Blog newBlog = new Blog(title, "", "", content, 0, 0, "Active");
        blogDAO.insert(newBlog);
        response.sendRedirect("/blog");
    }

    private void updateBlog(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        Blog blog = new Blog(id, title, "", "", content, 0, 0, "Active");
        blogDAO.update(blog);
        response.sendRedirect("/blog");
    }

    private void deleteBlog(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Blog blog = new Blog();
        blog.setId(id);
        blogDAO.delete(blog);
        response.sendRedirect("/blog");
    }
}
