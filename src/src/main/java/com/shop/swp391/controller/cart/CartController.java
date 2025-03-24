package com.shop.swp391.controller.cart;

import com.shop.swp391.dal.*;
import com.shop.swp391.entity.*;
import com.shop.swp391.Config.GlobalConfig;
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

    private void updateCartItem(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // Lấy mảng các cartItemId và quantity từ form
        String[] cartItemIds = req.getParameterValues("cartItemId");
        String[] quantities = req.getParameterValues("quantity");
        
        if (cartItemIds != null && quantities != null && cartItemIds.length == quantities.length) {
            for (int i = 0; i < cartItemIds.length; i++) {
                try {
                    int id = Integer.parseInt(cartItemIds[i]);
                    int qty = Integer.parseInt(quantities[i]);
                    
                    // Validate số lượng: nếu nhỏ hơn 1 thì gán lại bằng 1
                    if (qty < 1) {
                        System.out.println("Số lượng (" + qty + ") không hợp lệ cho cartItemID " + id + ". Gán lại giá trị tối thiểu là 1.");
                        qty = 1;
                    }
                    
                    // Cập nhật CartItem
                    CartItem item = cartItemDAO.findById(id);
                    if (item != null) {
                        item.setQuantity(qty);
                        // Nếu có nhiều bản ghi dư (cùng productId và variationId), bạn có thể cập nhật tất cả như đã hướng dẫn.
                        cartItemDAO.update(item);
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
        }
        
        resp.sendRedirect("cart?action=view");
    }
    
    private void removeCartItem(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int cartItemId = Integer.parseInt(req.getParameter("cartItemId"));
        CartItem item = cartItemDAO.findById(cartItemId);
        if (item != null) {
            cartItemDAO.delete(item);
        }

        resp.sendRedirect("cart?action=view");
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

        resp.sendRedirect("cart?action=view");
    }
    
    /**
     * Gộp các item có cùng productId và variationId lại với nhau và cộng số lượng.
     */
    private List<CartItem> groupCartItems(List<CartItem> items) {
        Map<String, CartItem> groupedItems = new HashMap<>();
        for (CartItem item : items) {
            String key = item.getProductId() + "_" + item.getVariationId();
            if (groupedItems.containsKey(key)) {
                CartItem existingItem = groupedItems.get(key);
                existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());
            } else {
                groupedItems.put(key, item);
            }
        }
        return new ArrayList<>(groupedItems.values());
    }
    
    private void viewCart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(GlobalConfig.SESSION_ACCOUNT);

        if (user == null) {
            resp.sendRedirect("/authen?action=login");
            return;
        }

        Cart cart = cartDAO.findByUserId(user.getId());
        double total = 0;
        
        if (cart != null) {
            List<CartItem> items = cartItemDAO.findByCartId(cart.getCartId());
            
            // Gộp các sản phẩm giống nhau
            items = groupCartItems(items);
            
            // Populate thông tin sản phẩm cho từng cartItem
            for (CartItem item : items) {
                Product product = productDAO.getProductById(item.getProductId());
                req.setAttribute("product_" + item.getCartItemId(), product);

                // Lấy thumbnail từ ProductImgDAO
                String thumbnail = productImgDAO.getProductThumbnail(product.getProductID());
                req.setAttribute("thumbnail_" + item.getCartItemId(), thumbnail);

                Variation variation = variationDAO.findById(item.getVariationId());
                if (variation != null) {
                    Color color = colorDAO.findById(variation.getColorID());
                    Size size = sizeDAO.findById(variation.getSizeID());
                    
                    req.setAttribute("color_" + item.getCartItemId(), color);
                    req.setAttribute("size_" + item.getCartItemId(), size);
                    
                    total += product.getPrice() * item.getQuantity();
                }
            }
            
            req.setAttribute("cartItems", items);
        }
        
        req.setAttribute("total", total);
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

    private void checkout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute(GlobalConfig.SESSION_ACCOUNT);

        if (user == null) {
            resp.sendRedirect("/authen?action=login");
            return;
        }

        // Lấy giỏ hàng của người dùng
        Cart cart = cartDAO.findByUserId(user.getId());
        double total = 0;

        // Tạo danh sách composite chứa các thông tin chi tiết của CartItem
        List<Map<String, Object>> cartItemDetails = new ArrayList<>();

        if (cart != null) {
            List<CartItem> items = cartItemDAO.findByCartId(cart.getCartId());
            // Gộp các sản phẩm giống nhau
            items = groupCartItems(items);
            for (CartItem item : items) {
                Map<String, Object> detail = new HashMap<>();
                detail.put("cartItem", item);

                // Lấy thông tin sản phẩm
                Product product = productDAO.getProductById(item.getProductId());
                detail.put("product", product);

                // Lấy thumbnail từ ProductImgDAO
                String thumbnail = productImgDAO.getProductThumbnail(product.getProductID());
                detail.put("thumbnail", thumbnail);

                // Lấy thông tin variation (và từ đó lấy màu, kích cỡ)
                Variation variation = variationDAO.findById(item.getVariationId());
                if (variation != null) {
                    Color color = colorDAO.findById(variation.getColorID());
                    Size size = sizeDAO.findById(variation.getSizeID());
                    detail.put("color", color);
                    detail.put("size", size);
                }

                total += product.getPrice() * item.getQuantity();
                cartItemDetails.add(detail);
            }
        }

        req.setAttribute("cartItemDetails", cartItemDetails);
        req.setAttribute("total", total);
        req.getRequestDispatcher("/view/cart/checkout.jsp").forward(req, resp);
    }
}
