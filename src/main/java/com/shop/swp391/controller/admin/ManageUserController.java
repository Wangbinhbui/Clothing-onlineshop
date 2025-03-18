/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.shop.swp391.controller.admin;

import com.shop.swp391.dal.UserDAO;
import com.shop.swp391.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "ManageUserController", urlPatterns = {"/manage-users"})
public class ManageUserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.equals("list")) {
            listWithFilters(request, response);
        } else {
            switch (action) {
                case "details":
                    showDetails(request, response);
                    break;
                case "addform":
                    showAddForm(request, response);
                    break;
                case "deactivate":
                    deactivateUser(request, response);
                    break;
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "update":
                updateUser(request, response);
                break;
            case "add":
                addUser(request, response);
                break;
            default:
                listWithFilters(request, response);
                break;
        }

    }

    public void listWithFilters(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String statusFilter = request.getParameter("status");
        String searchFilter = request.getParameter("search");
        String sexFilter = request.getParameter("sex");
        String roleFilter = request.getParameter("role");

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

        UserDAO userDAO = new UserDAO();
        List<User> users = userDAO.findUserWithFilters(roleFilter, sexFilter, statusFilter, searchFilter, page, pageSize);
        int totalUsers = userDAO.getTotalFilteredAccounts(roleFilter, sexFilter, statusFilter, searchFilter);

        int totalPages = (int) Math.ceil((double) totalUsers / pageSize);

        request.setAttribute("users", users);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalpages", totalPages);
        request.getRequestDispatcher("view/dashboard/admin/user-list.jsp").forward(request, response);

    }

    public void showDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdStr = request.getParameter("id");
        if (userIdStr != null && !userIdStr.isEmpty()) {
            int userId = Integer.parseInt(userIdStr);
            UserDAO userDAO = new UserDAO();
            User user = userDAO.findById(userId);
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("view/dashboard/admin/user-details.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/manage-users");
    }

    public void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/dashboard/admin/user-add.jsp").forward(request, response);
    }

    public void deactivateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdStr = request.getParameter("id");
        if (userIdStr != null && !userIdStr.isEmpty()) {
            int userId = Integer.parseInt(userIdStr);
            UserDAO userDAO = new UserDAO();
            boolean deactivated = userDAO.deactivateAccount(userId);
        }
        response.sendRedirect(request.getContextPath() + "/manage-users");
    }

    public void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdStr = request.getParameter("id");
        int userId = Integer.parseInt(userIdStr);
        UserDAO userDAO = new UserDAO();
        User user = userDAO.findById(userId);
        String roleIdStr = request.getParameter("role");
        String statusStr = request.getParameter("status");
        int roleId = Integer.parseInt(roleIdStr);
        boolean status = Boolean.parseBoolean(statusStr);

        user.setRoleId(roleId);
        user.setActive(status);

        boolean updated = userDAO.update(user);

        if (updated) {
            request.setAttribute("suc", "Update user sucessfully");
            request.setAttribute("user", user);
            request.getRequestDispatcher("view/dashboard/admin/user-details.jsp").forward(request, response);
        } else {
            request.setAttribute("err", "Failed to update user");
            request.setAttribute("user", user);
            request.getRequestDispatcher("view/dashboard/admin/user-details.jsp").forward(request, response);
        }
    }

    public void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String sexStr = request.getParameter("sex");
        String dob = request.getParameter("dob");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String roleIdStr = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean sex = Boolean.parseBoolean(sexStr);
        int roleId = Integer.parseInt(roleIdStr);

        UserDAO userDAO = new UserDAO();
        User user = new User(0, username, password, email, firstName, lastName, dob, sex, roleId, phone, true);
        int updated = userDAO.insert(user);

        if (updated > 1) {
            request.setAttribute("suc", "Add user sucessfully");
            request.setAttribute("user", user);
            request.getRequestDispatcher("view/dashboard/admin/user-add.jsp").forward(request, response);
        } else {
            request.setAttribute("err", "Failed to add user");
            request.setAttribute("user", user);
            request.getRequestDispatcher("view/dashboard/admin/user-add.jsp").forward(request, response);
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageAccountController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageAccountController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

}
