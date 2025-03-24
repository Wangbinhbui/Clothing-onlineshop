/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.shop.swp391.controller.home;

import com.shop.swp391.dal.ColorDAO;
import com.shop.swp391.dal.ProductDAO;
import com.shop.swp391.dal.ProductImgDAO;
import com.shop.swp391.entity.Color;
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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
    private static final int PAGE_SIZE = 9;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        String sortBy = request.getParameter("sortBy");
        String minPriceParam = request.getParameter("minPrice");
        String maxPriceParam = request.getParameter("maxPrice");
        String priceRange = request.getParameter("price");
        String colorParam = request.getParameter("color");
        Double minPrice = null;
        Double maxPrice = null;
        Integer colorID = null;
        if (priceRange != null && !priceRange.isEmpty()) {
            String[] prices = priceRange.replace("$", "").split(" - ");
            if (prices.length == 2) {
                try {
                    minPrice = Double.valueOf(prices[0].trim());
                    maxPrice = Double.valueOf(prices[1].trim());
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
        } else {
            if (minPriceParam != null && !minPriceParam.isEmpty()) {
                minPrice = Double.valueOf(minPriceParam);
            }
            if (maxPriceParam != null && !maxPriceParam.isEmpty()) {
                maxPrice = Double.valueOf(maxPriceParam);
            }
        }
        if (colorParam != null && !colorParam.isEmpty()) {
            colorID = Integer.valueOf(colorParam);
        }
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        int totalProducts = productDAO.getTotalProductCount();
        int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);
        if (page < 1) {
            page = 1;
        }
        if (page > totalPages) {
            page = totalPages;
        }
        List<Product> products = productDAO.findPagedProducts(page, PAGE_SIZE, sortBy, minPrice, maxPrice, colorID);
        Map<Integer, String> productImages = new HashMap<>();
        for (Product product : products) {
            String imagePath = productImgDAO.getProductThumbnail(product.getProductID());
            productImages.put(product.getProductID(), imagePath);
        }
        request.setAttribute("products", products);
        request.setAttribute("productImages", productImages);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);
        request.setAttribute("color", colorID);
        request.getRequestDispatcher("view/homepage/productlist.jsp").forward(request, response);
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
