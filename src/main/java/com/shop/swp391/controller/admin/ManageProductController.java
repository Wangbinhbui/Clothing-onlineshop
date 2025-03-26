/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.shop.swp391.controller.admin;

import com.shop.swp391.dal.CategoryDAO;
import com.shop.swp391.dal.CollectionDAO;
import com.shop.swp391.dal.ProductDAO;
import com.shop.swp391.dal.ProductImgDAO;
import com.shop.swp391.dal.VariationDAO;
import com.shop.swp391.entity.Category;
import com.shop.swp391.entity.Collection;
import com.shop.swp391.entity.Product;
import com.shop.swp391.entity.ProductImg;
import com.shop.swp391.entity.Variation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.nio.file.Paths;
import java.util.UUID;
import java.util.ArrayList;

/**
 *
 * @author PC
 */
@WebServlet(name = "ManageProductController", urlPatterns = {"/manage-products"})
@MultipartConfig
   
public class ManageProductController extends HttpServlet {

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
                case "changestatus":
                    changeProductStatus(request, response);
                    break;
                default:
                    listWithFilters(request, response);
                    break;
            }
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
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "update":
                updateProduct(request, response);
                break;
            case "add":
                addProduct(request, response);
                break;
            default:
                listWithFilters(request, response);
                break;
        }
    }

    private void listWithFilters(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryFilter = request.getParameter("category");
        String collectionFilter = request.getParameter("collection");
        String searchFilter = request.getParameter("search");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String statusStr = request.getParameter("status");
        
        Double minPrice = null;
        Double maxPrice = null;
        Integer status = null;
        
        if (minPriceStr != null && !minPriceStr.isEmpty()) {
            try {
                minPrice = Double.parseDouble(minPriceStr);
            } catch (NumberFormatException e) {
                // Ignore invalid input
            }
        }
        
        if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
            try {
                maxPrice = Double.parseDouble(maxPriceStr);
            } catch (NumberFormatException e) {
                // Ignore invalid input
            }
        }

        if (statusStr != null && !statusStr.isEmpty()) {
            try {
                status = Integer.parseInt(statusStr);
            } catch (NumberFormatException e) {
                // Ignore invalid input
            }
        }

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

        ProductDAO productDAO = new ProductDAO();
        List<Product> products;
        int totalProducts;
        
        Integer categoryId = null;
        Integer collectionId = null;
        
        if (categoryFilter != null && !categoryFilter.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryFilter);
            } catch (NumberFormatException e) {
                // Ignore invalid input
            }
        }
        
        if (collectionFilter != null && !collectionFilter.isEmpty()) {
            try {
                collectionId = Integer.parseInt(collectionFilter);
            } catch (NumberFormatException e) {
                // Ignore invalid input
            }
        }
        
        int offset = (page - 1) * pageSize;
        products = productDAO.findWithFilters(searchFilter, categoryId, collectionId, 
                                              minPrice, maxPrice, status);
        totalProducts = productDAO.countFilteredProducts(searchFilter, categoryId, collectionId, 
                                                       minPrice, maxPrice, status);
        
     
        // Load categories and collections for filters
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.findAll();
        
        CollectionDAO collectionDAO = new CollectionDAO();
        List<Collection> collections = collectionDAO.findAll();

        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("collections", collections);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("view/dashboard/admin/product-list.jsp").forward(request, response);
    }

    private void showDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(id);
            CategoryDAO categoryDAO = new CategoryDAO();
            List<Category> categories = categoryDAO.findAll();
            
            CollectionDAO collectionDAO = new CollectionDAO();
            List<Collection> collections = collectionDAO.findAll();
            
            // Fetch variations for this product
            VariationDAO variationDAO = new VariationDAO();
            List<Variation> variations = variationDAO.getVariationsByProductId(id);
            
            // Thêm options cho trạng thái
            Map<Integer, String> statusOptions = new HashMap<>();
            statusOptions.put(1, "Active");
            statusOptions.put(0, "Inactive");
            
            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            request.setAttribute("collections", collections);
            request.setAttribute("statusOptions", statusOptions);
            request.setAttribute("variations", variations);
            request.setAttribute("variationDAO", variationDAO);
            
            request.getRequestDispatcher("view/dashboard/admin/product-details.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid product ID");
            listWithFilters(request, response);
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Load categories and collections for dropdown
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.findAll();
        
        CollectionDAO collectionDAO = new CollectionDAO();
        List<Collection> collections = collectionDAO.findAll();
        
        // Thêm statusOptions
        Map<Integer, String> statusOptions = new HashMap<>();
        statusOptions.put(1, "Active");
        statusOptions.put(0, "Inactive");
        
        request.setAttribute("categories", categories);
        request.setAttribute("collections", collections);
        request.setAttribute("statusOptions", statusOptions);
        
        request.getRequestDispatcher("view/dashboard/admin/product-add.jsp").forward(request, response);
    }

    private void changeProductStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdStr = request.getParameter("id");
        String statusStr = request.getParameter("status");
        
        if (productIdStr != null && !productIdStr.isEmpty() && statusStr != null && !statusStr.isEmpty()) {
            try {
                int productId = Integer.parseInt(productIdStr);
                int newStatus = Integer.parseInt(statusStr);
                
                // Đảm bảo status chỉ là 0 hoặc 1
                newStatus = (newStatus == 1) ? 0 : 1; // Đảo ngược trạng thái
                
                ProductDAO productDAO = new ProductDAO();
                boolean updated = productDAO.changeStatus(productId, newStatus);
                
                if (updated) {
                    request.setAttribute("successMessage", "Product status changed successfully");
                } else {
                    request.setAttribute("errorMessage", "Failed to change product status");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid product ID or status");
            }
        }
        
        listWithFilters(request, response);
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String productName = request.getParameter("productName");
        String priceStr = request.getParameter("price");
        String categoryIdStr = request.getParameter("categoryId");
        String collectionIdStr = request.getParameter("collectionId");
        String description = request.getParameter("description");
        String statusStr = request.getParameter("status");
        
        try {
            int id = Integer.parseInt(idStr);
            double price = Double.parseDouble(priceStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            int collectionId = Integer.parseInt(collectionIdStr);
            int status = Integer.parseInt(statusStr);
            
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(id);
            
            if (product == null) {
                request.setAttribute("errorMessage", "Product not found");
                listWithFilters(request, response);
                return;
            }
            
            product.setProductName(productName);
            product.setPrice(price);
            product.setCategoryID(categoryId);
            product.setCollectionID(collectionId);
            product.setDescription(description);
            product.setStatus(status);
            
            boolean success = productDAO.update(product);
            
            if (success) {
                request.getSession().setAttribute("successMessage", "Product updated successfully");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to update product");
            }
            
            response.sendRedirect(request.getContextPath() + "/manage-products?action=details&id=" + id);
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid input data");
            showDetails(request, response);
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy thông tin cơ bản của sản phẩm
            String productName = request.getParameter("productName");
            double price = Double.parseDouble(request.getParameter("price"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            int collectionId = Integer.parseInt(request.getParameter("collectionId"));
            String description = request.getParameter("description");
            int status = Integer.parseInt(request.getParameter("status"));
            
            // Tạo đối tượng Product
            Product product = new Product();
            product.setProductName(productName);
            product.setPrice(price);
            product.setCategoryID(categoryId);
            product.setCollectionID(collectionId);
            product.setDescription(description);
            product.setStatus(status);
            
            // Thêm sản phẩm vào database
            ProductDAO productDAO = new ProductDAO();
            int productId = productDAO.insert(product);
            
            if (productId > 0) {
                // Không xử lý ảnh nữa
                request.getSession().setAttribute("successMessage", "Product added successfully");
                response.sendRedirect(request.getContextPath() + "/manage-products?action=details&id=" + productId);
            } else {
                request.setAttribute("errorMessage", "Failed to add product");
                showAddForm(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            showAddForm(request, response);
        }
    }
    
    // Phương thức hỗ trợ lưu file
    private String saveFile(Part filePart, String uploadPath) throws IOException {
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;
        filePart.write(uploadPath + File.separator + uniqueFileName);
        return uniqueFileName;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
