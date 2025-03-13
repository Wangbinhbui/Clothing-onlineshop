package com.shop.swp391.controller.home;

import com.shop.swp391.dal.StoryDAO;
import com.shop.swp391.entity.Story;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        StoryDAO storyDAO = new StoryDAO();

        if ("activate".equals(action)) {
            int storyId = Integer.parseInt(request.getParameter("storyId"));
            boolean updated = storyDAO.updateStoryStatus(storyId, "Active");
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": " + updated + "}");
        }
    }

}