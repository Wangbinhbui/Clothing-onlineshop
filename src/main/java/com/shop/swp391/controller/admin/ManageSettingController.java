/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.shop.swp391.controller.admin;

import com.shop.swp391.dal.SettingDAO;
import com.shop.swp391.entity.Setting;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name="ManageSettingController", urlPatterns={"/manage-settings"})
public class ManageSettingController extends HttpServlet {
   
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
                    deactivateSetting(request, response);
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
                updateSetting(request, response);
                break;
            case "add":
                addSetting(request, response);
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
        String typeFilter = request.getParameter("type");

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

        SettingDAO settingDAO = new SettingDAO();
        List<Setting> settings = settingDAO.findSettingWithFilters(typeFilter, statusFilter, searchFilter, page, pageSize);
        int totalSettings = settingDAO.getTotalFilteredSettings(typeFilter, statusFilter, searchFilter);

        int totalPages = (int) Math.ceil((double) totalSettings / pageSize);

        request.setAttribute("settings", settings);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalpages", totalPages);
        request.getRequestDispatcher("view/dashboard/admin/setting-list.jsp").forward(request, response);

    }

    public void showDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String settingIdStr = request.getParameter("id");
        if (settingIdStr != null && !settingIdStr.isEmpty()) {
            int settingId = Integer.parseInt(settingIdStr);
            SettingDAO settingDAO = new SettingDAO();
            Setting setting = settingDAO.findById(settingId);
            if (setting != null) {
                request.setAttribute("setting", setting);
                request.getRequestDispatcher("view/dashboard/admin/setting-details.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/manage-settings");
    }

    public void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/dashboard/admin/setting-add.jsp").forward(request, response);
    }

    public void deactivateSetting(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String settingIdStr = request.getParameter("id");
        if (settingIdStr != null && !settingIdStr.isEmpty()) {
            int settingId = Integer.parseInt(settingIdStr);
            SettingDAO settingDAO = new SettingDAO();
            boolean deactivated = settingDAO.deactivateSetting(settingId);
        }
        response.sendRedirect(request.getContextPath() + "/manage-settings");
    }

    public void updateSetting(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String settingIdStr = request.getParameter("id");
        int settingId = Integer.parseInt(settingIdStr);
        SettingDAO settingDAO = new SettingDAO();
        Setting setting = settingDAO.findById(settingId);
        
        String type = request.getParameter("type");
        String value = request.getParameter("value");
        String orderStr = request.getParameter("order");
        String status = request.getParameter("status");
        int order = Integer.parseInt(orderStr);

        setting.setType(type);
        setting.setValue(value);
        setting.setOrder(order);
        setting.setStatus(status);

        boolean updated = settingDAO.update(setting);

        if (updated) {
            request.setAttribute("suc", "Update setting sucessfully");
            request.setAttribute("setting", setting);
            request.getRequestDispatcher("view/dashboard/admin/setting-details.jsp").forward(request, response);
        } else {
            request.setAttribute("err", "Failed to update setting");
            request.setAttribute("setting", setting);
            request.getRequestDispatcher("view/dashboard/admin/setting-details.jsp").forward(request, response);
        }
    }

    public void addSetting(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type");
        String value = request.getParameter("value");
        String orderStr = request.getParameter("order");
        String status = request.getParameter("status");
        int order = Integer.parseInt(orderStr);

        SettingDAO settingDAO = new SettingDAO();
        Setting setting = new Setting(0, type, value, order, status, null, null);
        int updated = settingDAO.insert(setting);

        if (updated > 1) {
            request.setAttribute("suc", "Add setting sucessfully");
            request.setAttribute("setting", setting);
            request.getRequestDispatcher("view/dashboard/admin/setting-add.jsp").forward(request, response);
        } else {
            request.setAttribute("err", "Failed to add setting");
            request.setAttribute("setting", setting);
            request.getRequestDispatcher("view/dashboard/admin/setting-add.jsp").forward(request, response);
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
            out.println("<title>Servlet ManageSettingController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageSettingController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

}
