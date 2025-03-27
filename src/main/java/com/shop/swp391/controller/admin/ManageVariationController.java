/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.shop.swp391.controller.admin;

import com.shop.swp391.dal.VariationDAO;
import com.shop.swp391.dal.ColorDAO;
import com.shop.swp391.dal.SizeDAO;
import com.shop.swp391.entity.Variation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import jakarta.servlet.http.Part;
import com.shop.swp391.dal.ProductImgDAO;
import com.shop.swp391.entity.ProductImg;

/**
 *
 * @author PC
 */
@MultipartConfig
@WebServlet(name = "ManageVariationController", urlPatterns = {"/manage-variation"})
public class ManageVariationController extends HttpServlet {

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
                    deactivateUser(request, response);
                    break;
                case "add-variation":
                    showAddVariationForm(request, response);
                    break;
                case "delete-variation":
                    deleteVariation(request, response);
                    break;
            }
        }
       
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null && action.equals("add")) {
            try {
                // Lấy các tham số từ form
                int productId = Integer.parseInt(request.getParameter("productId"));
                int colorId = Integer.parseInt(request.getParameter("colorId"));
                int sizeId = Integer.parseInt(request.getParameter("sizeId"));
                int qtyInStock = Integer.parseInt(request.getParameter("qtyInStock"));
                
                // Xử lý upload ảnh - chỉ một ảnh
                Part filePart = request.getPart("productImg");
                
                // Lưu ảnh và lấy đường dẫn
                String imgPath = saveUploadedFile(filePart);
                if (imgPath == null) {
                    request.setAttribute("errorMessage", "Image file is required");
                    showAddVariationForm(request, response);
                    return;
                }
                
                // Tạo đối tượng Variation
                Variation variation = new Variation();
                variation.setProductID(productId);
                variation.setColorID(colorId);
                variation.setSizeID(sizeId);
                variation.setQtyInStock(qtyInStock);
                
                // Lưu thông tin ảnh vào database
                int productImgId = saveProductImage(imgPath);
                variation.setProductImgID(productImgId);
                
                // Gọi DAO để lưu variation
                VariationDAO variationDAO = new VariationDAO();
                boolean success = variationDAO.insert(variation) > 0;
                
                if (success) {
                    request.getSession().setAttribute("successMessage", "Variation added successfully!");
                    response.sendRedirect(request.getContextPath() + "/manage-products?action=details&id="+ productId);
                } else {
                    request.setAttribute("errorMessage", "Failed to add variation");
                    showAddVariationForm(request, response);
                }
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Error adding variation: " + e.getMessage());
                request.getRequestDispatcher("/view/dashboard/admin/add-variation.jsp").forward(request, response);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void listWithFilters(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         // Lấy các tham số search, màu và kích cỡ từ request
         String search = request.getParameter("search");
         String color = request.getParameter("color");
         String size = request.getParameter("size");
         String pageStr = request.getParameter("page");
         int page = 1;
         try {
             page = Integer.parseInt(pageStr);
         } catch (Exception e) {
             // Nếu không truyền hoặc lỗi, mặc định page = 1
         }
         int limit = 10;
         int offset = (page - 1) * limit;
         
         VariationDAO variationDAO = new VariationDAO();
         List<Variation> variations = variationDAO.findBySearchAndPaging(search, color, size, offset, limit);
         int totalCount = variationDAO.getTotalVariationsCount(search, color, size);
         int totalPages = (int) Math.ceil(totalCount * 1.0 / limit);
         
         List<Map<String, Object>> variationDetails = new ArrayList<>();
         for (Variation v : variations) {
             Map<String, Object> map = new HashMap<>();
             map.put("variation", v);             map.put("colorName", variationDAO.getColorNameById(v.getColorID()));
             map.put("sizeName", variationDAO.getSizeNameById(v.getSizeID()));
             map.put("thumbnail", variationDAO.getThumbnailById(v.getProductImgID()));
             variationDetails.add(map);
         }
         
         request.setAttribute("variationDetails", variationDetails);
         request.setAttribute("currentPage", page);
         request.setAttribute("totalPages", totalPages);
         request.setAttribute("search", search == null ? "" : search);
         request.setAttribute("color", color == null ? "" : color);
         request.setAttribute("size", size == null ? "" : size);
         
         // Lấy danh sách màu và kích cỡ để hiển thị dropdown
         ColorDAO colorDAO = new ColorDAO();
         SizeDAO sizeDAO = new SizeDAO();
         request.setAttribute("colorList", colorDAO.findAll());
         request.setAttribute("sizeList", sizeDAO.findAll());
         
         request.getRequestDispatcher("/view/dashboard/admin/variation-list.jsp").forward(request, response);
    }

    private void showDetails(HttpServletRequest request, HttpServletResponse response) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    private void deactivateUser(HttpServletRequest request, HttpServletResponse response) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    private void showAddVariationForm(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        String productId = request.getParameter("productId");
        // Lấy thông tin product từ productId nếu cần
        // Lấy danh sách màu sắc và kích cỡ từ DAO
        ColorDAO colorDAO = new ColorDAO();
        SizeDAO sizeDAO = new SizeDAO();
        
        request.setAttribute("productId", productId);
        request.setAttribute("colorList", colorDAO.findAll());
        request.setAttribute("sizeList", sizeDAO.findAll());
        
        request.getRequestDispatcher("/view/dashboard/admin/add-variation.jsp").forward(request, response);
    }

    private String saveUploadedFile(Part filePart) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }
        
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        
        String filePath = uploadPath + File.separator + fileName;
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
        }
        
        return "uploads/" + fileName;
    }

    private int saveProductImage(String imgPath) {
        ProductImg productImg = new ProductImg();
        productImg.setThumbnail(imgPath); // Set as thumbnail
        productImg.setProductImg1(imgPath);
        productImg.setProductImg2(null);
        productImg.setProductImg3(null);
        productImg.setProductImgName("Variation Image");
        
        ProductImgDAO productImgDAO = new ProductImgDAO();
        return productImgDAO.insert(productImg);
    }

    private void deleteVariation(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        try {
            int variationId = Integer.parseInt(request.getParameter("variationId"));
            
            // Get the variation to find its productId for redirect
            VariationDAO variationDAO = new VariationDAO();
            Variation variation = variationDAO.findById(variationId);
            
            if (variation == null) {
                request.getSession().setAttribute("errorMessage", "Variation not found");
                response.sendRedirect(request.getContextPath() + "/manage-products");
                return;
            }
            
            int productId = variation.getProductID();
            
            // Delete the variation
            boolean success = variationDAO.deleteById(variationId);
            
            if (success) {
                request.getSession().setAttribute("successMessage", "Variation deleted successfully");
            } else {
                request.getSession().setAttribute("errorMessage", "Could not delete variation. It may be linked to existing orders.");
            }
            
            // Redirect back to product details page
            response.sendRedirect(request.getContextPath() + "/manage-products?action=details&id=" + productId);
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid variation ID");
            response.sendRedirect(request.getContextPath() + "/manage-products");
        }
    }

}
