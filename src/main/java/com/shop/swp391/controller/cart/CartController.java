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
import java.lang.StringBuilder;

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
    private CountryDAO countryDAO;
    private AddressDAO addressDAO;
    private UserAddressDAO userAddressDAO;

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
        countryDAO = new CountryDAO();
        addressDAO = new AddressDAO();
        userAddressDAO = new UserAddressDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "view";
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
            case "apply-promo":
                applyPromotion(req, resp);
                break;
            case "processCheckout":
                processCheckoutFromDetails(req, resp);
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
            case "details":
                viewCartDetails(req, resp);
                break;
            case "checkout":
                checkout(req, resp);
                break;
            case "vnpay-return":
                handleVnPayReturn(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            // Nếu chưa đăng nhập, lưu thông báo lỗi và chuyển hướng về trang trước
            session.setAttribute("toastType", "error");
            session.setAttribute("toastMessage", "Please login first.");
            resp.sendRedirect(req.getHeader("referer"));
            return;
        }

        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            int colorId = Integer.parseInt(req.getParameter("colorId"));
            int sizeId = Integer.parseInt(req.getParameter("sizeId"));

            // Tìm variation dựa theo colorId và sizeId
            Variation variation = variationDAO.findByProductColorSize(productId, colorId, sizeId);
            if (variation == null) {
                session.setAttribute("toastType", "error");
                session.setAttribute("toastMessage", "Invalid color or size selection");
                resp.sendRedirect(req.getHeader("referer"));
                return;
            }

            // Kiểm tra tồn kho
            if (variation.getQtyInStock() <= 0) {
                session.setAttribute("toastType", "error");
                session.setAttribute("toastMessage", "Product is out of stock");
                resp.sendRedirect(req.getHeader("referer"));
                return;
            }

            if (variation.getQtyInStock() < quantity) {
                session.setAttribute("toastType", "error");
                session.setAttribute("toastMessage",
                        "Not enough stock. Only " + variation.getQtyInStock() + " available.");
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
            CartItem existingItem = findCartItemByProductAndVariation(cart.getCartId(), productId,
                    variation.getVariationID());
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

            // Tạo thông báo thành công
            Product product = productDAO.getProductById(productId);
            Color color = colorDAO.findById(colorId);
            Size size = sizeDAO.findById(sizeId);

            StringBuilder message = new StringBuilder();
            message.append(product.getProductName());
            message.append(" (Color: ").append(color.getColorName());
            message.append(", Size: ").append(size.getSizeName());
            message.append(") has been added to your cart");

            session.setAttribute("toastType", "success");
            session.setAttribute("toastMessage", message.toString());
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("toastType", "error");
            session.setAttribute("toastMessage", "Error adding product to cart: " + e.getMessage());
        }

        // Chuyển hướng về trang gửi trước (referer) hoặc trang mặc định nếu không có
        // referer
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
                        System.out.println("Số lượng (" + qty + ") không hợp lệ cho cartItemID " + id
                                + ". Gán lại giá trị tối thiểu là 1.");
                        qty = 1;
                    }

                    // Cập nhật CartItem
                    CartItem item = cartItemDAO.findById(id);
                    if (item != null) {
                        item.setQuantity(qty);
                        // Nếu có nhiều bản ghi dư (cùng productId và variationId), bạn có thể cập nhật
                        // tất cả như đã hướng dẫn.
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
     * Gộp các item có cùng productId và variationId lại với nhau và cộng số
     * lượng.
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
        User user = (User) session.getAttribute("account");

        if (user == null) {
            resp.sendRedirect("authen?action=login");
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
        User user = (User) session.getAttribute("account");

        if (user == null) {
            resp.sendRedirect("authen?action=login");
            return;
        }

        String paymentMethod = req.getParameter("paymentMethod");

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

        // Kiểm tra phương thức thanh toán
        if ("vnpay".equals(paymentMethod)) {
            // Chuẩn bị dữ liệu để gửi đến VNPAY

            // Tạo mã đơn hàng duy nhất
            String orderId = System.currentTimeMillis() + "";

            // Lưu thông tin đơn hàng vào session để xử lý sau khi thanh toán xong
            session.setAttribute("pendingOrderItems", cartItemDetails);
            session.setAttribute("pendingOrderTotal", total);
            session.setAttribute("pendingOrderId", orderId);

            // Chuyển hướng đến trang payment của AJAX servlet
            resp.sendRedirect(req.getContextPath() + "/ajaxServlet?action=pay&amount=" + Math.round(total) + "&orderId="
                    + orderId);
            return;
        } else if ("cod".equals(paymentMethod)) {
            // Xử lý đơn hàng thanh toán khi nhận hàng (COD)
            processOrder(user, cartItemDetails, total, "PENDING", req, resp);
        } else {
            // Nếu chưa chọn phương thức thanh toán, hiển thị trang checkout
            req.setAttribute("cartItemDetails", cartItemDetails);
            req.setAttribute("total", total);
            req.getRequestDispatcher("/view/cart/checkout.jsp").forward(req, resp);
        }
    }

    // Phương thức xử lý VNPAY trả về
    private void handleVnPayReturn(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            resp.sendRedirect("/authen?action=login");
            return;
        }

        // Lấy thông tin đơn hàng từ session
        List<Map<String, Object>> cartItemDetails = (List<Map<String, Object>>) session
                .getAttribute("pendingOrderItems");
        Double total = (Double) session.getAttribute("pendingOrderTotal");
        String orderId = (String) session.getAttribute("pendingOrderId");

        // Xóa thông tin đơn hàng tạm thời khỏi session
        session.removeAttribute("pendingOrderItems");
        session.removeAttribute("pendingOrderTotal");
        session.removeAttribute("pendingOrderId");

        // Lấy kết quả thanh toán từ VNPAY
        String vnp_ResponseCode = req.getParameter("vnp_ResponseCode");
        String vnp_TransactionStatus = req.getParameter("vnp_TransactionStatus");

        // Kiểm tra kết quả thanh toán
        if ("00".equals(vnp_ResponseCode) && "00".equals(vnp_TransactionStatus)) {
            // Thanh toán thành công
            processOrder(user, cartItemDetails, total, "PAID", req, resp);
        } else {
            // Thanh toán thất bại
            session.setAttribute("toastType", "error");
            session.setAttribute("toastMessage", "Thanh toán không thành công. Mã lỗi: " + vnp_ResponseCode);
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    // Phương thức xử lý đơn hàng sau khi thanh toán hoặc chọn COD
    private void processOrder(User user, List<Map<String, Object>> cartItemDetails, double total, String paymentStatus,
            HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        try {
            // Initialize order-related DAOs
            ShopOrderDAO orderDAO = new ShopOrderDAO();
            OrderDetailsDAO orderDetailDAO = new OrderDetailsDAO();

            // Create new shop order
            ShopOrder order = new ShopOrder();
            order.setUserID(user.getId());

            // TODO: Future enhancement - Allow user to select a shipping address
            // For now, we'll set addressID null and use user's information directly
            order.setAddressID(13);

            // Set order total (rounded to nearest integer)
            order.setOrderTotal((int) Math.round(total));

            // Set order status based on payment method
            // 1 = Pending (for COD)
            // 2 = Paid (for successful VNPAY payment)
            order.setOrderStatus(1);

            // Set recipient info from user data
            order.setRecipient(user.getFirstName() + " " + user.getLastName());
            order.setRecipientPhone(user.getPhone());

            // Insert order and get generated order ID
            int orderId = orderDAO.insert(order);

            if (orderId == -1) {
                throw new Exception("Failed to create order in database");
            }

            // Create order details for each cart item
            for (Map<String, Object> item : cartItemDetails) {
                CartItem cartItem = (CartItem) item.get("cartItem");
                Product product = (Product) item.get("product");

                OrderDetails orderDetail = new OrderDetails();
                orderDetail.setOrderID(orderId);
                orderDetail.setProductID(product.getProductID());
                orderDetail.setVariationID(cartItem.getVariationId());
                orderDetail.setQuantity(cartItem.getQuantity());

                // Set price (using product price)
                orderDetail.setPrice((int) Math.round(product.getPrice()));

                // Insert order detail
                int orderDetailId = orderDetailDAO.insert(orderDetail);

                if (orderDetailId == -1) {
                    throw new Exception("Failed to create order detail in database");
                }

                // Update product stock (decrease quantity)
                Variation variation = variationDAO.findById(cartItem.getVariationId());
                if (variation != null) {
                    int newStock = variation.getQtyInStock() - cartItem.getQuantity();
                    // Use the more efficient updateStockQuantity method
                    variationDAO.updateStockQuantity(variation.getVariationID(), newStock);
                }
            }

            // Clear the user's cart after successful order creation
            Cart cart = cartDAO.findByUserId(user.getId());
            if (cart != null) {
                List<CartItem> items = cartItemDAO.findByCartId(cart.getCartId());
                for (CartItem item : items) {
                    cartItemDAO.delete(item);
                }
            }

            // Set success message
            session.setAttribute("toastType", "success");
            session.setAttribute("toastMessage", "Đặt hàng thành công! "
                    + ("PAID".equals(paymentStatus) ? "Thanh toán đã hoàn tất."
                    : "Đơn hàng sẽ được thanh toán khi nhận hàng."));

            // TODO: Create an order confirmation page
            // For now, redirect to cart
            resp.sendRedirect(req.getContextPath() + "/cart");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("toastType", "error");
            session.setAttribute("toastMessage", "Có lỗi xảy ra khi xử lý đơn hàng: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }

    private void viewCartDetails(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            resp.sendRedirect("authen?action=login");
            return;
        }

        // Get cart items
        Cart cart = cartDAO.findByUserId(user.getId());
        double total = 0;
        double discount = 0;
        String appliedPromoCode = null;

        // Create a list to store cart item details
        List<Map<String, Object>> cartItemDetails = new ArrayList<>();

        if (cart != null) {
            List<CartItem> items = cartItemDAO.findByCartId(cart.getCartId());
            // Group similar items
            items = groupCartItems(items);

            for (CartItem item : items) {
                Map<String, Object> itemDetail = new HashMap<>();

                // Get product information
                Product product = productDAO.getProductById(item.getProductId());
                if (product == null) {
                    continue;
                }

                // Get variation details (color and size)
                Variation variation = variationDAO.findById(item.getVariationId());
                if (variation == null) {
                    continue;
                }

                Color color = colorDAO.findById(variation.getColorID());
                Size size = sizeDAO.findById(variation.getSizeID());

                // Get product image
                String imageUrl = "assets/images/product/default.jpg"; // Default image
                String thumbnail = productImgDAO.getProductThumbnail(product.getProductID());
                if (thumbnail != null && !thumbnail.isEmpty()) {
                    imageUrl = thumbnail;
                }

                // Calculate item total
                double itemPrice = product.getPrice();
                double itemTotal = itemPrice * item.getQuantity();
                total += itemTotal;

                // Add all details to the map
                itemDetail.put("cartItem", item);
                itemDetail.put("product", product);
                itemDetail.put("variation", variation);
                itemDetail.put("color", color);
                itemDetail.put("size", size);
                itemDetail.put("imageUrl", imageUrl);
                itemDetail.put("itemTotal", itemTotal);

                cartItemDetails.add(itemDetail);
            }

            // Check for applied promotion
            Promotion promotion = (Promotion) session.getAttribute("promotion");
            if (promotion != null) {
                discount = (promotion.getDiscountRate() / 100.0) * total;
                appliedPromoCode = promotion.getPromotionName();
            }
        }
        List<Country> countries = countryDAO.findAll();
        req.setAttribute("countries", countries);

        // Set attributes for the JSP
        req.setAttribute("cartItemDetails", cartItemDetails);
        req.setAttribute("total", total);
        req.setAttribute("discount", discount);
        req.setAttribute("finalTotal", total - discount);
        req.setAttribute("appliedPromoCode", appliedPromoCode);
        req.setAttribute("user", user);

        // Forward to cart-detail.jsp
        req.getRequestDispatcher("/view/cart/cart-detail.jsp").forward(req, resp);
    }

    private void processCheckoutFromDetails(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            resp.sendRedirect("authen?action=login");
            return;
        }

        try {
            // Get form data
            String firstName = req.getParameter("firstName");
            String lastName = req.getParameter("lastName");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String addressLine = req.getParameter("addressLine");
            String postalCode = req.getParameter("postalCode");
            String countryIDStr = req.getParameter("countryID");
            
            // Get province, district, ward names instead of codes
            String provinceName = req.getParameter("provinceName");
            String districtName = req.getParameter("districtName");
            String wardName = req.getParameter("wardName");
            
            String notes = req.getParameter("notes");
            String paymentMethod = req.getParameter("paymentMethod");

            // Validate required fields
            if (firstName == null || lastName == null || email == null || phone == null
                    || addressLine == null || postalCode == null || countryIDStr == null 
                    || provinceName == null || districtName == null || wardName == null) {
                req.setAttribute("errorMessage", "Please fill in all required fields");
                viewCartDetails(req, resp);
                return;
            }

            int countryID;
            try {
                countryID = Integer.parseInt(countryIDStr);
            } catch (NumberFormatException e) {
                req.setAttribute("errorMessage", "Invalid country selected");
                viewCartDetails(req, resp);
                return;
            }

            // Get cart items
            Cart cart = cartDAO.findByUserId(user.getId());
            double total = 0;
            double discount = 0;

            // Create a list to store cart item details
            List<Map<String, Object>> cartItemDetails = new ArrayList<>();

            if (cart != null) {
                List<CartItem> items = cartItemDAO.findByCartId(cart.getCartId());
                items = groupCartItems(items);

                for (CartItem item : items) {
                    Map<String, Object> itemDetail = new HashMap<>();

                    // Get product information
                    Product product = productDAO.getProductById(item.getProductId());
                    if (product == null) {
                        continue;
                    }

                    // Calculate item total
                    double itemPrice = product.getPrice();
                    double itemTotal = itemPrice * item.getQuantity();
                    total += itemTotal;

                    // Add details to the map
                    itemDetail.put("cartItem", item);
                    itemDetail.put("product", product);

                    cartItemDetails.add(itemDetail);
                }

                // Check for applied promotion
                Promotion promotion = (Promotion) session.getAttribute("promotion");
                if (promotion != null) {
                    discount = (promotion.getDiscountRate() / 100.0) * total;
                }
            }

            // Calculate final total
            double finalTotal = total - discount;

            // Create the city string from province, district, ward names
            String city = wardName + ", " + districtName + ", " + provinceName;

            // Create and save the new address
            Address address = new Address();
            address.setAddressLine(addressLine);
            address.setCity(city);
            address.setPostalCode(postalCode);
            address.setCountryID(countryID);

            // Insert the address and get its ID
            int addressID = addressDAO.insert(address);

            if (addressID == -1) {
                req.setAttribute("errorMessage", "Failed to save address information");
                viewCartDetails(req, resp);
                return;
            }

            // Link the address to the user
            userAddressDAO.insert(user.getId(), addressID);

            // Create full address for display
            String fullAddress = addressLine + ", " + city;

            if ("vnpay".equals(paymentMethod)) {
                // Store order information in session for later processing
                session.setAttribute("pendingOrderItems", cartItemDetails);
                session.setAttribute("pendingOrderTotal", finalTotal);
                session.setAttribute("pendingOrderId", "ORDER_" + System.currentTimeMillis());
                session.setAttribute("shippingAddress", fullAddress);
                session.setAttribute("recipientName", firstName + " " + lastName);
                session.setAttribute("recipientPhone", phone);
                session.setAttribute("orderNotes", notes);
                session.setAttribute("addressID", addressID);

                // Redirect to VNPAY payment
                checkout(req, resp);
            } else {
                // COD payment - process order directly
                ShopOrder order = new ShopOrder();
                order.setUserID(user.getId());

                // Use the newly created address
                order.setAddressID(addressID);

                // Set order total
                order.setOrderTotal((int) Math.round(finalTotal));

                // Set order status (1 = Pending for COD)
                order.setOrderStatus(1);

                // Set recipient info
                order.setRecipient(firstName + " " + lastName);
                order.setRecipientPhone(phone);

                // Store shipping address and notes in session for later use
                session.setAttribute("shippingAddress", fullAddress);
                session.setAttribute("orderNotes", notes);

                // Process the order
                processOrder(user, cartItemDetails, finalTotal, "COD", req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            viewCartDetails(req, resp);
        }
    }
}
