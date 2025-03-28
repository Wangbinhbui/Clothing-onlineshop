package com.shop.swp391.controller;

import com.shop.swp391.controller.utils.EmailUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/test-email")
public class TestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String toEmail = request.getParameter("email");
        if (toEmail == null || toEmail.isEmpty()) {
            response.getWriter().println("Vui lòng truyền ?email=...");
            return;
        }

        String otp = EmailUtils.sendOTPMail(getServletContext(), toEmail);

        response.setContentType("text/plain");
        response.getWriter().println("OTP đã gửi tới " + toEmail + ": " + otp);
    }
}
