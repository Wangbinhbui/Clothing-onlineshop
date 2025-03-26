package com.shop.swp391.controller.home;

import com.shop.swp391.dal.ProductImgDAO;
import com.shop.swp391.entity.ProductImg;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet để xử lý các yêu cầu AJAX lấy hình ảnh sản phẩm
 */
@WebServlet(name = "ProductImagesController", urlPatterns = {"/product-images"})
public class ProductImagesController extends HttpServlet {

    /**
     * Xử lý yêu cầu GET để lấy hình ảnh theo productImgID
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        
        String imgIdParam = request.getParameter("imgId");
        if (imgIdParam == null || imgIdParam.isEmpty()) {
            sendError(response, "Missing imgId parameter");
            return;
        }
        
        try {
            int imgId = Integer.parseInt(imgIdParam);
            
            // Lấy hình ảnh sản phẩm
            ProductImgDAO productImgDAO = new ProductImgDAO();
            ProductImg productImg = productImgDAO.getById(imgId);
            
            if (productImg == null) {
                sendError(response, "Product image not found");
                return;
            }
            
            // Tạo danh sách hình ảnh
            List<String> images = new ArrayList<>();
            
            // Thêm các hình ảnh không rỗng vào danh sách
            if (productImg.getThumbnail() != null && !productImg.getThumbnail().isEmpty()) {
                images.add(productImg.getThumbnail());
            }
            if (productImg.getProductImg1() != null && !productImg.getProductImg1().isEmpty()) {
                images.add(productImg.getProductImg1());
            }
            if (productImg.getProductImg2() != null && !productImg.getProductImg2().isEmpty()) {
                images.add(productImg.getProductImg2());
            }
            if (productImg.getProductImg3() != null && !productImg.getProductImg3().isEmpty()) {
                images.add(productImg.getProductImg3());
            }
            
            // Trả về dữ liệu JSON
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"success\": true, \"images\": [");
                for (int i = 0; i < images.size(); i++) {
                    out.print("\"" + images.get(i) + "\"");
                    if (i < images.size() - 1) {
                        out.print(", ");
                    }
                }
                out.print("]}");
            }
            
        } catch (NumberFormatException e) {
            sendError(response, "Invalid imgId parameter");
        }
    }
    
    /**
     * Gửi phản hồi lỗi dưới dạng JSON
     */
    private void sendError(HttpServletResponse response, String message) throws IOException {
        try (PrintWriter out = response.getWriter()) {
            out.print("{\"success\": false, \"error\": \"" + message + "\"}");
        }
    }
} 