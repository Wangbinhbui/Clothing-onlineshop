package com.shop.swp391.controller.utils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Simple controller to remove toast message attributes from the session
 * after they have been displayed.
 */
@WebServlet(name = "RemoveToastController", urlPatterns = {"/remove-toast"})
public class RemoveToastController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Remove toast message attributes
        session.removeAttribute("toastMessage");
        session.removeAttribute("toastType");
        
        // Return a simple success response
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write("Toast attributes removed");
    }
} 