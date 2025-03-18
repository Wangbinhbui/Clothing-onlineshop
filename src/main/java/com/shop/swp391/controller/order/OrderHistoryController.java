package com.shop.swp391.controller.order;

import com.shop.swp391.config.GlobalConfig;
import com.shop.swp391.dal.OrderDetailsDAO;
import com.shop.swp391.dal.ProductDAO;
import com.shop.swp391.dal.ShopOrderDAO;
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

@WebServlet(name = "OrderHistoryController", urlPatterns = {"/order-history"})
public class OrderHistoryController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
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
            response.sendRedirect(request.getContextPath() + "/order-history");
            return;
        }
        
        switch (action) {
            case "cancel":
                cancelOrder(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/order-history");
                break;
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(GlobalConfig.SESSION_ACCOUNT);
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
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
        
        // Get status filter if exists
        String statusFilter = request.getParameter("status");
        
        ShopOrderDAO shopOrderDAO = new ShopOrderDAO();
        List<ShopOrder> orders = shopOrderDAO.getOrdersByUserIdWithPagination(user.getId(), statusFilter, page, pageSize);
        int totalOrders = shopOrderDAO.getTotalOrdersByUserId(user.getId(), statusFilter);
        int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
        
        request.setAttribute("orders", orders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("statusFilter", statusFilter);
        
        // Get order status map for display
        Map<Integer, String> orderStatusMap = new HashMap<>();
        orderStatusMap.put(1, "Pending");
        orderStatusMap.put(2, "Prepared Order");
        orderStatusMap.put(3, "Package Order");
        orderStatusMap.put(4, "Delivering");
        orderStatusMap.put(5, "Successfully");
        
        request.setAttribute("orderStatusMap", orderStatusMap);
        
        request.getRequestDispatcher("/view/order/order-history.jsp").forward(request, response);
    }

    private void viewOrderDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(GlobalConfig.SESSION_ACCOUNT);
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String orderIdStr = request.getParameter("id");
        if (orderIdStr == null || orderIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/order-history");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            
            ShopOrderDAO shopOrderDAO = new ShopOrderDAO();
            ShopOrder order = shopOrderDAO.getById(orderId);
            
            if (order == null || order.getUserID() != user.getId()) {
                // Order not found or doesn't belong to the user
                setToastMessage(request, "Order not found or you don't have permission to view it", "error");
                response.sendRedirect(request.getContextPath() + "/order-history");
                return;
            }
            
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
            orderStatusMap.put(2, "Prepared Order");
            orderStatusMap.put(3, "Package Order");
            orderStatusMap.put(4, "Delivering");
            orderStatusMap.put(5, "Successfully");
            
            request.setAttribute("order", order);
            request.setAttribute("orderDetails", orderDetailsList);
            request.setAttribute("productMap", productMap);
            request.setAttribute("orderStatusMap", orderStatusMap);
            
            request.getRequestDispatcher("/view/order/order-details.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            setToastMessage(request, "Invalid order ID", "error");
            response.sendRedirect(request.getContextPath() + "/order-history");
        }
    }

    private void cancelOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(GlobalConfig.SESSION_ACCOUNT);
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String orderIdStr = request.getParameter("id");
        if (orderIdStr == null || orderIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/order-history");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            
            ShopOrderDAO shopOrderDAO = new ShopOrderDAO();
            ShopOrder order = shopOrderDAO.getById(orderId);
            
            if (order == null || order.getUserID() != user.getId()) {
                // Order not found or doesn't belong to the user
                setToastMessage(request, "Order not found or you don't have permission to cancel it", "error");
                response.sendRedirect(request.getContextPath() + "/order-history");
                return;
            }
            
            // Can only cancel orders in status 1 (Pending)
            if (order.getOrderStatus() != 1) {
                setToastMessage(request, "Only pending orders can be cancelled", "error");
                response.sendRedirect(request.getContextPath() + "/order-history?action=details&id=" + orderId);
                return;
            }
            
            boolean cancelled = shopOrderDAO.cancelOrder(orderId);
            
            if (cancelled) {
                setToastMessage(request, "Order cancelled successfully", "success");
            } else {
                setToastMessage(request, "Failed to cancel order", "error");
            }
            
            response.sendRedirect(request.getContextPath() + "/order-history");
            
        } catch (NumberFormatException e) {
            setToastMessage(request, "Invalid order ID", "error");
            response.sendRedirect(request.getContextPath() + "/order-history");
        }
    }
    
    private void setToastMessage(HttpServletRequest request, String message, String type) {
        request.getSession().setAttribute("toastMessage", message);
        request.getSession().setAttribute("toastType", type);
    }
} 