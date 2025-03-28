/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.shop.swp391.controller.home;

import com.shop.swp391.dal.ProductDAO;
import com.shop.swp391.dal.ProductImgDAO;
import com.shop.swp391.entity.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author hung
 */
@WebServlet(name = "ProductListController", urlPatterns = {"/products"})
public class ProductListController extends HttpServlet {

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
            out.println("<title>Servlet ProductListController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductListController at " + request.getContextPath() + "</h1>");
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Set character encoding for request and response
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");
            
            // Initialize ProductDAO
            ProductDAO productDAO = new ProductDAO();
            
            // Get min and max product prices from database
            double dbMinPrice = productDAO.getMinProductPrice();
            double dbMaxPrice = productDAO.getMaxProductPrice();
            
            // Get parameters from request
            String searchQuery = request.getParameter("search");
            String pageParam = request.getParameter("page");
            String minPriceParam = request.getParameter("minPrice");
            String maxPriceParam = request.getParameter("maxPrice");
            String colorIdParam = request.getParameter("colorId");
            String sortBy = request.getParameter("sortBy");
            String genderParam = request.getParameter("gender");
            
            // Parse parameters
            int currentPage = 1;
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                    if (currentPage < 1) {
                        currentPage = 1;
                    }
                } catch (NumberFormatException e) {
                    // Invalid page parameter, default to 1
                    currentPage = 1;
                }
            }
            
            Double minPrice = null;
            if (minPriceParam != null && !minPriceParam.isEmpty()) {
                try {
                    minPrice = Double.parseDouble(minPriceParam);
                } catch (NumberFormatException e) {
                    // Invalid minPrice parameter, ignore it
                }
            }
            
            Double maxPrice = null;
            if (maxPriceParam != null && !maxPriceParam.isEmpty()) {
                try {
                    maxPrice = Double.parseDouble(maxPriceParam);
                } catch (NumberFormatException e) {
                    // Invalid maxPrice parameter, ignore it
                }
            }
            
            Integer colorId = null;
            if (colorIdParam != null && !colorIdParam.isEmpty()) {
                try {
                    colorId = Integer.parseInt(colorIdParam);
                } catch (NumberFormatException e) {
                    // Invalid colorId parameter, ignore it
                }
            }
            
            // Define items per page
            int pageSize = 6;
            
            // Get total products count based on filters
            int totalProducts = productDAO.countProductsWithFilters(searchQuery, minPrice, maxPrice, colorId, genderParam);
            
            // Calculate total pages
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
            
            // Adjust currentPage if needed
            if (currentPage > totalPages && totalPages > 0) {
                currentPage = totalPages;
            }
            
            // Calculate pagination variables
            int pagesToShow = 5;
            int halfPagesToShow = pagesToShow / 2;
            int startPage = Math.max(1, currentPage - halfPagesToShow);
            int endPage = Math.min(totalPages, startPage + pagesToShow - 1);
            if (endPage - startPage + 1 < pagesToShow) {
                startPage = Math.max(1, endPage - pagesToShow + 1);
            }
            
            // Get list of products for current page
            List<Product> products = productDAO.searchProductsWithFilters(searchQuery, currentPage, pageSize, sortBy, minPrice, maxPrice, colorId, genderParam);
            
            // Get thumbnail for each product
            ProductImgDAO productImgDAO = new ProductImgDAO();
            Map<Integer, String> thumbnails = new HashMap<>();
            for (Product product : products) {
                thumbnails.put(product.getProductID(), productImgDAO.getProductThumbnail(product.getProductID()));
            }
            
            // Build pagination URL
            String paginationUrl = buildPaginationUrl(request);
            
            // Set attributes for the JSP
            request.setAttribute("products", products);
            request.setAttribute("thumbnails", thumbnails);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("paginationUrl", paginationUrl);
            request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);
            
            // Set filter attributes for JSP
            request.setAttribute("search", searchQuery);
            request.setAttribute("minPrice", minPrice);
            request.setAttribute("maxPrice", maxPrice);
            request.setAttribute("colorId", colorId);
            request.setAttribute("sortBy", sortBy != null ? sortBy : "default");
            request.setAttribute("gender", genderParam);
            
            // Set database min/max price attributes for the price filter
            request.setAttribute("dbMinPrice", dbMinPrice);
            request.setAttribute("dbMaxPrice", dbMaxPrice);
            
            // Forward to product list page
            request.getRequestDispatcher("/view/homepage/productlist.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
        }
    }

    /**
     * Builds the pagination URL maintaining all current query parameters except page
     * @param request The HTTP request
     * @return URL string with query parameters
     */
    private String buildPaginationUrl(HttpServletRequest request) {
        StringBuilder url = new StringBuilder("products?");
        Map<String, String[]> parameters = request.getParameterMap();
        boolean firstParam = true;
        
        for (Map.Entry<String, String[]> entry : parameters.entrySet()) {
            String paramName = entry.getKey();
            String[] paramValues = entry.getValue();
            
            // Skip the page parameter, as it will be added in the pagination links
            if ("page".equals(paramName)) {
                continue;
            }
            
            for (String paramValue : paramValues) {
                if (!firstParam) {
                    url.append("&");
                } else {
                    firstParam = false;
                }
                url.append(paramName).append("=").append(paramValue);
            }
        }
        
        if (!firstParam) {
            url.append("&");
        }
        
        return url.toString();
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

