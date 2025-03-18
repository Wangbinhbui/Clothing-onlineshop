package com.shop.swp391.controller.cart;

import com.shop.swp391.dal.*;
import com.shop.swp391.entity.*;
import com.shop.swp391.config.GlobalConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;

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
    private ProductImgDAO productImgDAO;

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
        productImgDAO = new ProductImgDAO();
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
            action = "view";
        }

        switch (action) {
            case "view":
                viewCart(req, resp);
                break;
            case "checkout":
                checkout(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(GlobalConfig.SESSION_ACCOUNT);

        if (user == null) {
            // Nếu chưa đăng nhập, lưu thông báo lỗi và chuyển hướng về trang trước
            session.setAttribute("toastError", "Please login first.");
            resp.sendRedirect(req.getHeader("referer"));
            return;
        }
        
        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            int colorId = Integer.parseInt(req.getParameter("colorId"));
            int sizeId = Integer.parseInt(req.getParameter("sizeId"));

            // Tìm variation dựa theo colorId và sizeId
            Variation variation = variationDAO.findByColorIdAndSizeId(colorId, sizeId);
            if (variation == null) {
                session.setAttribute("toastError", "Invalid color or size selection");
                resp.sendRedirect(req.getHeader("referer"));
                return;
            }

            // Lấy hoặc tạo giỏ hàng cho user
            Cart cart = cartDAO.findByUserId(user.getId());
            if (cart == null) {
                cart = new Cart();
                cart.setUserId(user.getId());
                int cartId = cartDAO.insert(cart);
                cart.setCartId(cartId);
            }

            // Kiểm tra xem sản phẩm đã tồn tại với variation này trong giỏ chưa
            CartItem existingItem = findCartItemByProductAndVariation(cart.getCartId(), productId, variation.getVariationID());
            if (existingItem != null) {
                existingItem.setQuantity(existingItem.getQuantity() + quantity);
                cartItemDAO.update(existingItem);
            } else {
                CartItem newItem = new CartItem();
                newItem.setCartId(cart.getCartId());
                newItem.setProductId(productId);
                newItem.setVariationId(variation.getVariationID());
                newItem.setQuantity(quantity);
                cartItemDAO.insert(newItem);
            }

            session.setAttribute("toastMessage", "Product added to cart successfully");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("toastError", "Có lỗi khi thêm sản phẩm vào giỏ: " + e.getMessage());
        }

        // Chuyển hướng về trang gửi trước (referer) hoặc trang mặc định nếu không có referer
        String referer = req.getHeader("referer");
        if (referer == null || referer.isEmpty()) {
            referer = "productdetails.jsp";
        }
        resp.sendRedirect(referer);
    }

    
}
