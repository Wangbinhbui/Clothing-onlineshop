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

/**
 *
 * @author PC
 */
@WebServlet(name = "ManageCustomerController", urlPatterns = {"/manage-customers"})
public class ManageCustomerController extends HttpServlet {

   
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void listWithFilters(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String statusFilter = request.getParameter("status");
        String searchFilter = request.getParameter("search");
        String sexFilter = request.getParameter("sex");

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
        List<User> users = userDAO.findCustomerWithFilters( sexFilter, statusFilter, searchFilter, page, pageSize);
        int totalUsers = userDAO.getTotalFilteredCustomer(sexFilter, statusFilter, searchFilter);

        int totalPages = (int) Math.ceil((double) totalUsers / pageSize);

        request.setAttribute("users", users);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalpages", totalPages);
        request.getRequestDispatcher("view/dashboard/admin/customer-list.jsp").forward(request, response);

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
                request.getRequestDispatcher("view/dashboard/admin/customer-details.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/manage-users");
    }

   

}
