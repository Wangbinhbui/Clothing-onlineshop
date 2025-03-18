package com.shop.swp391.controller.admin;

import com.shop.swp391.config.GlobalConfig;
import com.shop.swp391.dal.OrderDetailsDAO;
import com.shop.swp391.dal.ProductDAO;
import com.shop.swp391.dal.ShopOrderDAO;
import com.shop.swp391.dal.UserDAO;
import com.shop.swp391.entity.OrderDetails;
import com.shop.swp391.entity.Product;
import com.shop.swp391.entity.ShopOrder;
import com.shop.swp391.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "OrderManagementController", urlPatterns = {"/admin/orders"})
public class OrderManagementController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        // Check if user is admin
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute(GlobalConfig.SESSION_ACCOUNT);
        
        if (admin == null || admin.getRoleId() != 1) { // Assuming roleId 1 is admin
            setToastMessage(request, "You don't have permission to access this page", "error");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        switch (action) {
            case "list":
                listOrders(request, response);
                break;
            case "details":
                viewOrderDetails(request, response);
                break;
            default:
                listOrders(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }
        
        // Check if user is admin
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute(GlobalConfig.SESSION_ACCOUNT);
        
        if (admin == null || admin.getRoleId() != 1) { // Assuming roleId 1 is admin
            setToastMessage(request, "You don't have permission to access this page", "error");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        switch (action) {
            case "update-status":
                updateOrderStatus(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/orders");
                break;
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get pagination parameters
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
        
        // Get filters if they exist
        String statusFilter = request.getParameter("status");
        String userIdFilter = request.getParameter("userId");
        String searchQuery = request.getParameter("search");
        
        ShopOrderDAO shopOrderDAO = new ShopOrderDAO();
        List<ShopOrder> orders = shopOrderDAO.getAllOrdersWithPagination(statusFilter, userIdFilter, searchQuery, page, pageSize);
        int totalOrders = shopOrderDAO.getTotalOrders(statusFilter, userIdFilter, searchQuery);
        int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
        
        // Get user information for each order
        UserDAO userDAO = new UserDAO();
        Map<Integer, User> userMap = new HashMap<>();
        
        for (ShopOrder order : orders) {
            if (order.getUserID() != null && !userMap.containsKey(order.getUserID())) {
                User user = userDAO.findById(order.getUserID());
                if (user != null) {
                    userMap.put(order.getUserID(), user);
                }
            }
        }
        
        request.setAttribute("orders", orders);
        request.setAttribute("userMap", userMap);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("userIdFilter", userIdFilter);
        request.setAttribute("searchQuery", searchQuery);
        
        // Get order status map for display
        Map<Integer, String> orderStatusMap = new HashMap<>();
        orderStatusMap.put(1, "Pending");
        orderStatusMap.put(2, "Prepared");
        orderStatusMap.put(3, "Packaged");
        orderStatusMap.put(4, "Delivering");
        orderStatusMap.put(5, "Successfully");
        orderStatusMap.put(6, "Cancelled");
        
        request.setAttribute("orderStatusMap", orderStatusMap);
        
        request.getRequestDispatcher("/view/admin/order-management.jsp").forward(request, response);
    }

    private void viewOrderDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdStr = request.getParameter("id");
        if (orderIdStr == null || orderIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            
            ShopOrderDAO shopOrderDAO = new ShopOrderDAO();
            ShopOrder order = shopOrderDAO.getById(orderId);
            
            if (order == null) {
                setToastMessage(request, "Order not found", "error");
                response.sendRedirect(request.getContextPath() + "/admin/orders");
                return;
            }
            
            // Get user information
            UserDAO userDAO = new UserDAO();
            User user = userDAO.findById(order.getUserID());
            
            OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
            List<OrderDetails> orderDetailsList = orderDetailsDAO.getByOrderId(orderId);
            
            // Get product information for each order detail
            ProductDAO productDAO = new ProductDAO();
            Map<Integer, Product> productMap = new HashMap<>();
            
            for (OrderDetails detail : orderDetailsList) {
                if (!productMap.containsKey(detail.getProductID())) {
                    Product product = productDAO.getById(detail.getProductID());
                    if (product != null) {
                        productMap.put(detail.getProductID(), product);
                    }
                }
            }
            
            // Get order status map for display
            Map<Integer, String> orderStatusMap = new HashMap<>();
            orderStatusMap.put(1, "Pending");
            orderStatusMap.put(2, "Prepared");
            orderStatusMap.put(3, "Packaged");
            orderStatusMap.put(4, "Delivering");
            orderStatusMap.put(5, "Successfully");
            orderStatusMap.put(6, "Cancelled");
            
            request.setAttribute("order", order);
            request.setAttribute("user", user);
            request.setAttribute("orderDetails", orderDetailsList);
            request.setAttribute("productMap", productMap);
            request.setAttribute("orderStatusMap", orderStatusMap);
            
            request.getRequestDispatcher("/view/admin/admin-order-details.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            setToastMessage(request, "Invalid order ID", "error");
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdStr = request.getParameter("id");
        String statusStr = request.getParameter("status");
        
        if (orderIdStr == null || orderIdStr.isEmpty() || statusStr == null || statusStr.isEmpty()) {
            setToastMessage(request, "Invalid parameters", "error");
            response.sendRedirect(request.getContextPath() + "/admin/orders");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            int status = Integer.parseInt(statusStr);
            
            // Validate status is in valid range
            if (status < 1 || status > 6) {
                setToastMessage(request, "Invalid status value", "error");
                response.sendRedirect(request.getContextPath() + "/admin/orders?action=details&id=" + orderId);
                return;
            }
            
            ShopOrderDAO shopOrderDAO = new ShopOrderDAO();
            boolean updated = shopOrderDAO.updateOrderStatus(orderId, status);
            
            if (updated) {
                setToastMessage(request, "Order status updated successfully", "success");
            } else {
                setToastMessage(request, "Failed to update order status", "error");
            }
            
            response.sendRedirect(request.getContextPath() + "/admin/orders?action=details&id=" + orderId);
            
        } catch (NumberFormatException e) {
            setToastMessage(request, "Invalid parameters", "error");
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }
    
    private void setToastMessage(HttpServletRequest request, String message, String type) {
        request.getSession().setAttribute("toastMessage", message);
        request.getSession().setAttribute("toastType", type);
    }
} 