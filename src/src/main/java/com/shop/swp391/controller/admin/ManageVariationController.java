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
                
                // Xử lý upload ảnh
                Part filePart1 = request.getPart("productImg1");
                Part filePart2 = request.getPart("productImg2");
                Part filePart3 = request.getPart("productImg3");
                
                // Lưu ảnh và lấy đường dẫn
                String imgPath1 = saveUploadedFile(filePart1);
                String imgPath2 = saveUploadedFile(filePart2);
                String imgPath3 = saveUploadedFile(filePart3);
                
                // Tạo đối tượng Variation
                Variation variation = new Variation();
                variation.setProductID(productId);
                variation.setColorID(colorId);
                variation.setSizeID(sizeId);
                variation.setQtyInStock(qtyInStock);
                
                // Lưu thông tin ảnh vào database (cần thêm logic xử lý)
                // Ví dụ: tạo bản ghi trong bảng product_img và lấy ID
                int productImgId = saveProductImages(imgPath1, imgPath2, imgPath3);
                variation.setProductImgID(productImgId);
                
                // Gọi DAO để lưu variation
                VariationDAO variationDAO = new VariationDAO();
                boolean success = variationDAO.insert(variation) > 0;
                
                if (success) {
                    request.getSession().setAttribute("successMessage", "Variation added successfully!");
                    response.sendRedirect(request.getContextPath() + "/manage-products?action=details&id="+ productId);
                } else {
                    request.setAttribute("errorMessage", "Failed to add variation");
                    request.getRequestDispatcher("/view/dashboard/admin/add-variation.jsp").forward(request, response);
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

    private int saveProductImages(String imgPath1, String imgPath2, String imgPath3) {
        ProductImg productImg = new ProductImg();
        productImg.setThumbnail(imgPath1); // Sử dụng ảnh đầu tiên làm thumbnail
        productImg.setProductImg1(imgPath1);
        productImg.setProductImg2(imgPath2);
        productImg.setProductImg3(imgPath3);
        productImg.setProductImgName("Variation Images");
        
        ProductImgDAO productImgDAO = new ProductImgDAO();
        return productImgDAO.insert(productImg);
    }

}
