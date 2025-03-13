package com.shop.swp391.controller.blog;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import com.shop.swp391.dal.BlogDAO;
import com.shop.swp391.dal.BlogCategoryDAO;
import com.shop.swp391.entity.Blog;
import com.shop.swp391.entity.BlogCategory;
import jakarta.servlet.annotation.MultipartConfig;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10,       // 10 MB
        maxRequestSize = 1024 * 1024 * 15       // 15 MB
)
@WebServlet(name = "ManageBlogController", urlPatterns = {"/blog"})
public class ManageBlogController extends HttpServlet {
    private BlogDAO blogDAO;
    private BlogCategoryDAO blogCategoryDAO;

    @Override
    public void init() throws ServletException {
        blogDAO = new BlogDAO();
        blogCategoryDAO = new BlogCategoryDAO();
        // Load danh mục một lần khi khởi tạo và lưu vào application scope
        List<BlogCategory> categories = blogCategoryDAO.findAll();
        getServletContext().setAttribute("categories", categories);
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
            case "category":
                listBlogsByCategory(request, response);
                break;
            default:
                listBlogs(request, response);
                break;
        }
    }

    // Lấy danh sách blog và truyền danh mục từ application scope
    private void listBlogs(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Blog> blogs = blogDAO.findAll();
        // Lấy danh mục từ application scope
        List<BlogCategory> categories = (List<BlogCategory>) getServletContext().getAttribute("categories");
        request.setAttribute("blogs", blogs);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("view/blog/blog.jsp").forward(request, response);
    }

    // Lọc blog theo category được chọn
    private void listBlogsByCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("category"));
        List<Blog> blogs = blogDAO.findByCategory(categoryId);
        // Lấy danh mục từ application scope
        List<BlogCategory> categories = (List<BlogCategory>) getServletContext().getAttribute("categories");
        request.setAttribute("blogs", blogs);
        request.setAttribute("categories", categories);
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
        // Lấy danh mục từ application scope
        List<BlogCategory> categories = (List<BlogCategory>) getServletContext().getAttribute("categories");
        request.setAttribute("blog", blog);
        request.setAttribute("categories", categories);
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
        String brief = request.getParameter("brief");
        String image = request.getParameter("image");
        int categoryId = Integer.parseInt(request.getParameter("category")); // Lấy category từ request
        int authorId = Integer.parseInt(request.getParameter("author"));     // Lấy author từ hidden field
        String status = request.getParameter("status");
        if (status == null || status.trim().isEmpty()) {
            status = "Active";
        }

        Blog newBlog = Blog.builder()
                .title(title)
                .content(content)
                .briefInfo(brief)
                .thumbnail(image)
                .author(authorId)
                .categoryId(categoryId)
                .status(status)
                .build();
        blogDAO.insert(newBlog);
        response.sendRedirect("blog?action=list");
    }

    private void updateBlog(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String brief = request.getParameter("brief");
            String image = request.getParameter("image");
            int categoryId = Integer.parseInt(request.getParameter("category")); // Lấy category từ request
            int authorId = Integer.parseInt(request.getParameter("author"));     // Lấy author từ form/hidden field
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
            // Xử lý lỗi nếu id hoặc category không hợp lệ
        }
        response.sendRedirect("blog?action=list");
    }

    private void deleteBlog(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Blog blog = new Blog();
        blog.setId(id);
        blogDAO.delete(blog);
        response.sendRedirect("blog?action=list");
    }
}
