/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.shop.swp391.controller.home;

import com.shop.swp391.dal.ProductDAO;
import com.shop.swp391.dal.ProductImgDAO;
import com.shop.swp391.dal.VariationDAO;
import com.shop.swp391.entity.Color;
import com.shop.swp391.entity.Product;
import com.shop.swp391.entity.Size;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import com.shop.swp391.entity.Variation;
import java.util.ArrayList;
import com.shop.swp391.entity.ProductImg;

/**
 *
 * @author hung
 */
@WebServlet(name = "ProductDetailController", urlPatterns = {"/product-detail"})
public class ProductDetailController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductDetailController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetailController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private final ProductDAO productDAO = new ProductDAO();
    private final ProductImgDAO productImgDAO = new ProductImgDAO();
    private final VariationDAO variationDAO = new VariationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String productIdParam = request.getParameter("productID");
        if (productIdParam == null || productIdParam.isEmpty()) {
            response.sendRedirect("productlist.jsp");
            return;
        }
        try {
            int productId = Integer.parseInt(productIdParam);

            // Fetch product details
            Product product = productDAO.getProductById(productId);
            if (product == null) {
                response.sendRedirect("productlist.jsp");
                return;
            }
            
            // Get color variants
            List<Color> colors = productDAO.getAvailableColors(productId);
            
            // Get size variants
            List<Size> sizes = productDAO.getAvailableSizes(productId);
            
            // Xác định màu và kích thước mặc định (lấy phần tử đầu tiên)
            int defaultColorId = colors.isEmpty() ? 0 : colors.get(0).getColorID();
            int defaultSizeId = sizes.isEmpty() ? 0 : sizes.get(0).getSizeID();
            
            // Lấy variation mặc định
            Variation defaultVariation = variationDAO.findByProductColorSize(productId, defaultColorId, defaultSizeId);
            
            // Get product images ONLY for default variation
            List<String> productImages = new ArrayList<>();
            if (defaultVariation != null) {
                // Get images from the product_img table for this specific variation
                int imgId = defaultVariation.getProductImgID();
                ProductImg productImg = productImgDAO.getById(imgId);
                if (productImg != null) {
                    if (productImg.getThumbnail() != null && !productImg.getThumbnail().isEmpty())
                        productImages.add(productImg.getThumbnail());
                    if (productImg.getProductImg1() != null && !productImg.getProductImg1().isEmpty())
                        productImages.add(productImg.getProductImg1());
                    if (productImg.getProductImg2() != null && !productImg.getProductImg2().isEmpty())
                        productImages.add(productImg.getProductImg2());
                    if (productImg.getProductImg3() != null && !productImg.getProductImg3().isEmpty())
                        productImages.add(productImg.getProductImg3());
                }
            }
            
            // Get default thumbnail
            String productThumbnail = !productImages.isEmpty() ? productImages.get(0) : "default.jpg";
            
            // Get color-specific thumbnails
            Map<Integer, String> colorThumbnails = new HashMap<>();
            for (Color color : colors) {
                colorThumbnails.put(color.getColorID(), 
                    productImgDAO.getProductThumbnailByColor(productId, color.getColorID()));
            }
            
            // Get available variations for this product (to show stock status)
            Map<String, Integer> variationStockMap = new HashMap<>();
            for (Color color : colors) {
                for (Size size : sizes) {
                    Variation variation = variationDAO.findByProductColorSize(productId, color.getColorID(), size.getSizeID());
                    if (variation != null) {
                        String key = color.getColorID() + "-" + size.getSizeID();
                        variationStockMap.put(key, variation.getQtyInStock());
                    }
                }
            }
            
            // Tạo mapping: Màu -> ProductImgID
            Map<Integer, Integer> colorToImgMap = new HashMap<>();
            for (Color color : colors) {
                // Lấy variation đầu tiên của màu này để lấy productImgID
                Variation variation = variationDAO.findByProductColorSize(productId, color.getColorID(), defaultSizeId);
                if (variation != null) {
                    colorToImgMap.put(color.getColorID(), variation.getProductImgID());
                }
            }
            
            // Set all attributes for JSP
            request.setAttribute("product", product);
            request.setAttribute("thumbnail", productThumbnail);
            request.setAttribute("productImages", productImages);
            request.setAttribute("colors", colors);
            request.setAttribute("sizes", sizes);
            request.setAttribute("colorThumbnails", colorThumbnails);
            request.setAttribute("variationStock", variationStockMap);
            request.setAttribute("defaultColorId", defaultColorId);
            request.setAttribute("defaultSizeId", defaultSizeId);
            request.setAttribute("colorToImgMap", colorToImgMap);
            
            // Pass DAOs to JSP for additional queries
            request.setAttribute("variationDAO", variationDAO);
            request.setAttribute("productImgDAO", productImgDAO);
            
            request.getRequestDispatcher("view/homepage/productdetails.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("productlist.jsp");
        }
    }
    

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
