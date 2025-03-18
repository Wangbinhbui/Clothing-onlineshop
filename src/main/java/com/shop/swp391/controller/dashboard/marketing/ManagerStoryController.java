/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.shop.swp391.controller.dashboard.marketing;

/**
 *
 * @author Quang
 */
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.shop.swp391.dal.StoryDAO;
import com.shop.swp391.dal.UserDAO;
import com.shop.swp391.entity.Story;
import com.shop.swp391.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
@WebServlet(name = "ManagerStoryController", urlPatterns = {"/manage-story"})
public class ManagerStoryController extends HttpServlet {

    private final StoryDAO storyDAO = new StoryDAO();
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
                    deleteStory(request, response);
                    break;
                case "deactivate":
                    deactivateStory(request, response);
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
                addStory(request, response);
                break;
            case "update":
                updateStory(request, response);
                break;

            default:
                handleListWithFilters(request, response);
                break;
        }
    }

    private void handleListWithFilters(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchFilter = request.getParameter("search");
        String statusFilter = request.getParameter("status");

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

        List<Story> stories = storyDAO.findStoriesWithFilters(searchFilter, statusFilter, page, pageSize);
        int totalStories = storyDAO.getTotalStories(searchFilter, statusFilter);
        int totalPages = (int) Math.ceil((double) totalStories / pageSize);

        List<User> users = userDAO.findAll();
        Map<Integer, User> userMap = users.stream()
                .collect(Collectors.toMap(User::getId, item -> item));

        request.setAttribute("stories", stories);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalStories", totalStories);
        request.setAttribute("userMap", userMap);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("searchFilter", searchFilter);

        request.getRequestDispatcher("view/marketing/slider_list.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String storyIdStr = request.getParameter("id");
        if (storyIdStr != null && !storyIdStr.isEmpty()) {
            int storyId = Integer.parseInt(storyIdStr);
            Story story = storyDAO.findById(storyId);
            if (story != null) {
                request.setAttribute("story", story);
                request.getRequestDispatcher("view/marketing/slider_details.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/manage-story");
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/marketing/slider_add.jsp").forward(request, response);
    }

    private void addStory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
//        User user = (User) session.getAttribute("user");
//        if (user == null) {
//            response.sendRedirect(request.getContextPath() + "/login");
//            return;
//        }

        String title = request.getParameter("title");
        String backlink = request.getParameter("backlink");
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        Part filePart = request.getPart("thumbnail");
        String fileName = null;
        if (description == null || description.trim().isEmpty()) {
            description = "<p>No description provided.</p>";
        }
        if (filePart != null && filePart.getSize() > 0) {
            fileName = System.currentTimeMillis() + "_" + getFileName(filePart);
            String uploadPath = request.getServletContext().getRealPath("") + "assets/images/story";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            filePart.write(uploadPath + File.separator + fileName);
        }

        Story story = Story.builder()
                .title(title)
                .thumbnail(fileName != null ? ("assets/images/story/" + fileName) : null)
                .backlink(backlink)
                .description(description)
                .status(status)
                .build();

        int result = storyDAO.insert(story);
        if (result > 0) {
            session.setAttribute("toastMessage", "Story added successfully!");
            session.setAttribute("toastType", "success");
        } else {
            session.setAttribute("toastMessage", "Failed to add story!");
            session.setAttribute("toastType", "error");
        }
        response.sendRedirect(request.getContextPath() + "/manage-story");
    }

    private void updateStory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
//        User user = (User) session.getAttribute("user");
//        if (user == null) {
//            response.sendRedirect(request.getContextPath() + "/login");
//            return;
//        }

        int storyId = Integer.parseInt(request.getParameter("id"));
        Story story = storyDAO.findById(storyId);

        String title = request.getParameter("title");
        String backlink = request.getParameter("backlink");
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        if (description == null || description.trim().isEmpty()) {
            description = "<p>No description provided.</p>";
        }
        Part filePart = request.getPart("thumbnail");
        if (filePart != null && filePart.getSize() > 0) {
            if (story.getThumbnail() != null && !story.getThumbnail().isEmpty()) {
                String oldThumbnailPath = request.getServletContext().getRealPath("") + story.getThumbnail();
                File oldThumbnail = new File(oldThumbnailPath);
                if (oldThumbnail.exists()) {
                    oldThumbnail.delete();
                }
            }

            // Save new image
            String fileName = System.currentTimeMillis() + "_" + getFileName(filePart);
            String uploadPath = request.getServletContext().getRealPath("") + "assets/images/story";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            filePart.write(uploadPath + File.separator + fileName);
            story.setThumbnail("assets/images/story/" + fileName);
        }

        story.setTitle(title);
        story.setBacklink(backlink);
        story.setDescription(description);
        story.setStatus(status);

        boolean result = storyDAO.update(story);
        if (result) {
            session.setAttribute("toastMessage", "Story updated successfully!");
            session.setAttribute("toastType", "success");
        } else {
            session.setAttribute("toastMessage", "Failed to update story!");
            session.setAttribute("toastType", "error");
        }
        response.sendRedirect(request.getContextPath() + "/manage-story");
    }

    private void deactivateStory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int storyId = Integer.parseInt(request.getParameter("id"));
        Story story = storyDAO.findById(storyId);

        if (story != null) {
            story.setStatus("Inactive");
            storyDAO.update(story);
        }
        response.sendRedirect(request.getContextPath() + "/manage-story");
    }

    private String getFileName(Part part) {
        return part.getSubmittedFileName();
    }

    private void deleteStory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Lấy storyId từ request
        int storyId;
        try {
            storyId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            session.setAttribute("toastMessage", "Invalid story ID!");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/manage-story");
            return;
        }

        // Tìm kiếm story trong DB
        Story story = storyDAO.findById(storyId);
        if (story == null) {
            session.setAttribute("toastMessage", "Story not found!");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/manage-story");
            return;
        }

        // Nếu story có ảnh, xóa ảnh trước
        if (story.getThumbnail() != null && !story.getThumbnail().isEmpty()) {
            String imagePath = request.getServletContext().getRealPath("") + story.getThumbnail();
            File imageFile = new File(imagePath);
            if (imageFile.exists() && imageFile.delete()) {
                System.out.println("Deleted image: " + story.getThumbnail());
            } else {
                System.out.println("Failed to delete image: " + story.getThumbnail());
            }
        }

        // Xóa story khỏi database
        boolean result = storyDAO.delete(story);
        if (result) {
            session.setAttribute("toastMessage", "Story deleted successfully!");
            session.setAttribute("toastType", "success");
        } else {
            session.setAttribute("toastMessage", "Failed to delete story!");
            session.setAttribute("toastType", "error");
        }

        // Chuyển hướng về danh sách story
        response.sendRedirect(request.getContextPath() + "/manage-story");
    }

}
