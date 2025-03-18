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

    

}
