package com.shop.swp391.controller.cart;

import com.shop.swp391.dal.*;
import com.shop.swp391.entity.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    private CartDAO cartDAO;
    private CartItemDAO cartItemDAO;
    private ProductDAO productDAO;
    private PromotionDAO promotionDAO;
    private UserDAO userDAO;
    private VariationDAO variationDAO;
    private ColorDAO colorDAO;
    private SizeDAO sizeDAO;

    @Override
    public void init() {
        cartDAO = new CartDAO();
        cartItemDAO = new CartItemDAO();
        productDAO = new ProductDAO();
        promotionDAO = new PromotionDAO();
        userDAO = new UserDAO();
        variationDAO = new VariationDAO();
        colorDAO = new ColorDAO();
        sizeDAO = new SizeDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "add":
                addToCart(req, resp);
                break;
            case "update":
                updateCartItem(req, resp);
                break;
            case "remove":
                removeCartItem(req, resp);
                break;
            case "apply-promotion":
                applyPromotion(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "view":
                viewCart(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("/authen?action=login");
            return;
        }

        int productId = Integer.parseInt(req.getParameter("productId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        int colorId = Integer.parseInt(req.getParameter("colorId"));
        int sizeId = Integer.parseInt(req.getParameter("sizeId"));

        // Tìm variationId từ colorId và sizeId
        Variation variation = variationDAO.findByColorIdAndSizeId(colorId, sizeId);
        if (variation == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid color or size selection");
            return;
        }

        // Get or create cart for user
        Cart cart = cartDAO.findByUserId(user.getId());
        if (cart == null) {
            cart = new Cart();
            cart.setUserId(user.getId());
            int cartId = cartDAO.insert(cart);
            cart.setCartId(cartId);
        }

        // Check if item already exists in cart
        CartItem existingItem = findCartItemByProductAndVariation(cart.getCartId(), productId, variation.getVariationID());
        if (existingItem != null) {
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
            cartItemDAO.update(existingItem);
        } else {
            CartItem newItem = new CartItem();
            newItem.setCartId(cart.getCartId());
            newItem.setProductId(productId);
            newItem.setQuantity(quantity);
            newItem.setVariationId(variation.getVariationID());
            cartItemDAO.insert(newItem);
        }

        resp.sendRedirect("/cart/view");
    }

    private void updateCartItem(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int cartItemId = Integer.parseInt(req.getParameter("cartItemId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        CartItem item = cartItemDAO.findById(cartItemId);
        if (item != null) {
            item.setQuantity(quantity);
            cartItemDAO.update(item);
        }

        resp.sendRedirect("/cart/view");
    }

    private void removeCartItem(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int cartItemId = Integer.parseInt(req.getParameter("cartItemId"));
        CartItem item = cartItemDAO.findById(cartItemId);
        if (item != null) {
            cartItemDAO.delete(item);
        }

        resp.sendRedirect("/cart/view");
    }

    private void applyPromotion(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        String promotionCode = req.getParameter("promotionCode");

        Promotion promotion = promotionDAO.findByPromotionCode(promotionCode);
        if (promotion != null) {
            session.setAttribute("promotion", promotion);
        } else {
            session.setAttribute("errorMessage", "Invalid promotion code.");
        }

        resp.sendRedirect("/cart/view");
    }

    private void viewCart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("/authen?action=login");
            return;
        }

        Cart cart = cartDAO.findByUserId(user.getId());
        if (cart != null) {
            List<CartItem> items = cartItemDAO.findByCartId(cart.getCartId());
            for (CartItem item : items) {
                Product product = productDAO.getProductById(item.getProductId());
                item.setProduct(product);

                // Lấy thông tin Variation từ variationId
                Variation variation = variationDAO.findById(item.getVariationId());
                if (variation != null) {
                    // Lấy thông tin Color và Size từ Variation
                    Color color = new Color(variation.getColorID(), "Color Name"); // Thay "Color Name" bằng tên màu thực tế nếu có
                    Size size = new Size(variation.getSizeID(), "Size Name"); // Thay "Size Name" bằng tên kích thước thực tế nếu có

                    // Đặt thông tin color và size vào request để sử dụng trong JSP
                    req.setAttribute("color", color);
                    req.setAttribute("size", size);
                }
            }

            double total = calculateTotal(cart, (Promotion) session.getAttribute("promotion"));
            req.setAttribute("cartItems", items);
            req.setAttribute("total", total);
        }

        req.getRequestDispatcher("/view/cart/cart.jsp").forward(req, resp);
    }

    private double calculateTotal(Cart cart, Promotion promotion) {
        List<CartItem> items = cartItemDAO.findByCartId(cart.getCartId());
        double total = 0;

        for (CartItem item : items) {
            Product product = productDAO.getProductById(item.getProductId());
            total += product.getPrice() * item.getQuantity();
        }

        if (promotion != null) {
            total *= (1 - promotion.getDiscountRate());
        }

        return total;
    }

    private CartItem findCartItemByProductAndVariation(int cartId, int productId, int variationId) {
        List<CartItem> items = cartItemDAO.findByCartId(cartId);
        for (CartItem item : items) {
            if (item.getProductId() == productId && item.getVariationId() == variationId) {
                return item;
            }
        }
        return null;
    }
}
