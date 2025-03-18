package com.shop.swp391.controller.order;

import com.shop.swp391.dal.CartDAO;
import com.shop.swp391.dal.CartItemDAO;
import com.shop.swp391.dal.OrderDetailsDAO;
import com.shop.swp391.dal.ProductDAO;
import com.shop.swp391.dal.ShopOrderDAO;
import com.shop.swp391.entity.User;
import com.shop.swp391.entity.Cart;
import com.shop.swp391.entity.CartItem;
import com.shop.swp391.entity.OrderDetails;
import com.shop.swp391.entity.Product;
import com.shop.swp391.entity.ShopOrder;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "OrderController", urlPatterns = {"/order"})
public class OrderController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect("cart");
            return;
        }
        
        switch (action) {
            case "view":
                viewOrders(request, response);
                break;
            case "detail":
                viewOrderDetail(request, response);
                break;
            default:
                response.sendRedirect("cart");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect("cart");
            return;
        }
        
        switch (action) {
            case "place":
                placeOrder(request, response);
                break;
            default:
                response.sendRedirect("cart");
                break;
        }
    }
    
    private void placeOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        
        // Combine first name and last name to create recipient name
        String recipientName = firstName + " " + lastName;
        
        // Get cart and cart items
        CartDAO cartDAO = new CartDAO();
        Cart cart = cartDAO.getByUserID(user.getId());
        
        if (cart == null) {
            session.setAttribute("toastMessage", "No cart found");
            session.setAttribute("toastType", "error");
            response.sendRedirect("checkout");
            return;
        }
        
        CartItemDAO cartItemDAO = new CartItemDAO();
        List<CartItem> cartItems = cartItemDAO.getByCartId(cart.getCartId());
        
        if (cartItems.isEmpty()) {
            session.setAttribute("toastMessage", "Your cart is empty");
            session.setAttribute("toastType", "error");
            response.sendRedirect("checkout");
            return;
        }
        
        // Calculate order total
        int orderTotal = calculateOrderTotal(cartItems);
        
        // Create new order (AddressID = 0 will be handled as NULL in DAO)
        ShopOrder order = ShopOrder.builder()
                .userID(user.getId())
                .addressID(0)
                .orderTotal(orderTotal)
                .orderStatus(1) // 1 = Pending
                .recipient(recipientName)
                .recipientPhone(phone)
                .build();
        
        // Save order to database
        ShopOrderDAO orderDAO = new ShopOrderDAO();
        int orderId = orderDAO.insert(order);
        
        if (orderId <= 0) {
            session.setAttribute("toastMessage", "Failed to create order. Please try again.");
            session.setAttribute("toastType", "error");
            response.sendRedirect("checkout");
            return;
        }
        
        // Create order details for each cart item
        OrderDetailsDAO orderDetailsDAO = new OrderDetailsDAO();
        boolean allItemsProcessed = saveOrderDetails(cartItems, orderId, orderDetailsDAO);
        
        if (!allItemsProcessed) {
            System.out.println("Some items failed to process in order " + orderId);
        }
        
        // Clear the cart
        for (CartItem item : cartItems) {
            cartItemDAO.delete(item.getCartItemId());
        }
        
        // Set success message into session for toast notification
        session.setAttribute("toastMessage", "Your order has been placed successfully!");
        session.setAttribute("toastType", "success");
        response.sendRedirect(request.getContextPath() + "/view/cart/checkout.jsp");
    }
    
    private int calculateOrderTotal(List<CartItem> cartItems) {
        ProductDAO productDAO = new ProductDAO();
        int total = 0;
        
        for (CartItem item : cartItems) {
            Product product = productDAO.getById(item.getProductId());
            if (product != null) {
                total += product.getPrice() * item.getQuantity();
            }
        }
        
        return total;
    }
    
    private boolean saveOrderDetails(List<CartItem> cartItems, int orderId, OrderDetailsDAO orderDetailsDAO) {
        ProductDAO productDAO = new ProductDAO();
        boolean allSuccess = true;
        
        // Lưu ý: Loại bỏ trường orderDate vì database không có cột này
        for (CartItem item : cartItems) {
            Product product = productDAO.getById(item.getProductId());
            if (product == null) {
                allSuccess = false;
                continue;
            }
            
            OrderDetails orderDetail = OrderDetails.builder()
                    .productID(item.getProductId())
                    .orderID(orderId)
                    .quantity(item.getQuantity())
                    .price((int) product.getPrice())
                    .variationID(item.getVariationId())
                    .build();
            
            int detailId = orderDetailsDAO.insert(orderDetail);
            if (detailId <= 0) {
                allSuccess = false;
            }
        }
        
        return allSuccess;
    }
    
    private void viewOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // This method would show a list of user's orders
        response.sendRedirect("home");
    }
    
    private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // This method would display details of a specific order
        response.sendRedirect("home");
    }
} 