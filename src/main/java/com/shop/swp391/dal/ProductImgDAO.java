/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.shop.swp391.dal;

import com.shop.swp391.entity.ProductImg;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hung
 */
public class ProductImgDAO extends DBContext implements I_DAO<ProductImg> {

    @Override
    public List<ProductImg> findAll() {
        List<ProductImg> productImgs = new ArrayList<>();
        String sql = "SELECT * FROM product_img";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                productImgs.add(getFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return productImgs;
    }

    @Override
    public boolean update(ProductImg t) {
        String sql = "UPDATE product_img SET thumbnail = ?, product_img_1 = ?, product_img_2 = ?, product_img_3 = ?, product_img_name = ? WHERE product_img_ID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, t.getThumbnail());
            statement.setString(2, t.getProductImg1());
            statement.setString(3, t.getProductImg2());
            statement.setString(4, t.getProductImg3());
            statement.setString(5, t.getProductImgName());
            statement.setInt(6, t.getProductImgID());
            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            System.out.println("Error updating ProductImg: " + ex.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }

    @Override
    public boolean delete(ProductImg t) {
        String sql = "DELETE FROM product_img WHERE product_img_ID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, t.getProductImgID());
            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            System.out.println("Error deleting ProductImg: " + ex.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }

    @Override
    public int insert(ProductImg t) {
        String sql = "INSERT INTO product_img (thumbnail, product_img_1, product_img_2, product_img_3, product_img_name) VALUES (?, ?, ?, ?, ?)";
        try {
            connection = getConnection();
            // Sử dụng Statement.RETURN_GENERATED_KEYS để lấy id tự tăng
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, t.getThumbnail());
            statement.setString(2, t.getProductImg1());
            statement.setString(3, t.getProductImg2());
            statement.setString(4, t.getProductImg3());
            statement.setString(5, t.getProductImgName());
            int affectedRows = statement.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating ProductImg failed, no rows affected.");
            }
            resultSet = statement.getGeneratedKeys();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            } else {
                throw new SQLException("Creating ProductImg failed, no ID obtained.");
            }
        } catch (SQLException ex) {
            System.out.println("Error inserting ProductImg: " + ex.getMessage());
            return -1;
        } finally {
            closeResources();
        }
    }

    @Override
    public ProductImg getFromResultSet(ResultSet rs) throws SQLException {
        ProductImg productImg = new ProductImg();
        productImg.setProductImgID(rs.getInt("product_img_ID"));
        productImg.setThumbnail(rs.getString("thumbnail"));
        productImg.setProductImg1(rs.getString("product_img_1"));
        productImg.setProductImg2(rs.getString("product_img_2"));
        productImg.setProductImg3(rs.getString("product_img_3"));
        productImg.setProductImgName(rs.getString("product_img_name"));
        return productImg;
    }

    public String getProductThumbnail(int productId) {
        String sql = "SELECT pi.thumbnail FROM product_img pi " +
                   "JOIN variation v ON pi.product_img_ID = v.product_img_ID " +
                   "WHERE v.ProductID = ? " +
                   "LIMIT 1";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("thumbnail");
            }
        } catch (SQLException ex) {
            System.out.println("Error getting product thumbnail: " + ex.getMessage());
            ex.printStackTrace();
        } finally {
            closeResources();
        }
        return "default.jpg";
    }
    
    /**
     * Get all images for a product
     * @param productId The product ID
     * @return List of image paths
     */
    public List<String> getProductImages(int productId) {
        List<String> images = new ArrayList<>();
        String sql = "SELECT pi.thumbnail, pi.product_img_1, pi.product_img_2, pi.product_img_3 " +
                   "FROM product_img pi " +
                   "JOIN variation v ON pi.product_img_ID = v.product_img_ID " +
                   "WHERE v.ProductID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                addIfNotEmpty(images, resultSet.getString("thumbnail"));
                addIfNotEmpty(images, resultSet.getString("product_img_1"));
                addIfNotEmpty(images, resultSet.getString("product_img_2"));
                addIfNotEmpty(images, resultSet.getString("product_img_3"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            closeResources();
        }
        return images;
    }

    private void addIfNotEmpty(List<String> list, String value) {
        if (value != null && !value.trim().isEmpty()) {
            list.add(value);
        }
    }

    public static void main(String[] args) {
        ProductImgDAO productImgDAO = new ProductImgDAO();
        int testProductId = 15;
        
        // Test getProductThumbnail
        String imagePath = productImgDAO.getProductThumbnail(testProductId);
        System.out.println("Thumbnail for ProductID " + testProductId + ": " + imagePath);
        
        // Test getProductImages
        List<String> images = productImgDAO.getProductImages(testProductId);
        System.out.println("All images for ProductID " + testProductId + ":");
        for (String img : images) {
            System.out.println("- " + img);
        }
    }

    public int insert(ProductImg productImg, int productId) {
        String sql = "INSERT INTO product_img (ProductID, thumbnail, product_img_1, product_img_2, product_img_3, product_img_name) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setInt(1, productId);
            statement.setString(2, productImg.getThumbnail());
            statement.setString(3, productImg.getProductImg1());
            statement.setString(4, productImg.getProductImg2());
            statement.setString(5, productImg.getProductImg3());
            statement.setString(6, productImg.getProductImgName());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating product image failed, no rows affected.");
            }
            
            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating product image failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        } finally {
            closeResources();
        }
    }

    /**
     * Get a product thumbnail for a specific product ID and color ID
     * 
     * @param productId The product ID
     * @param colorId The color ID
     * @return The thumbnail path or default.jpg if not found
     */
    public String getProductThumbnailByColor(int productId, int colorId) {
        String sql = "SELECT pi.thumbnail FROM product_img pi " +
                    "JOIN variation v ON pi.product_img_ID = v.product_img_ID " +
                    "WHERE v.ProductID = ? AND v.color_ID = ? " +
                    "LIMIT 1";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            statement.setInt(2, colorId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("thumbnail");
            }
        } catch (SQLException ex) {
            System.out.println("Error getting product thumbnail by color: " + ex.getMessage());
            ex.printStackTrace();
        } finally {
            closeResources();
        }
        return getProductThumbnail(productId); // Fallback to any thumbnail for this product
    }
    
    /**
     * Get a ProductImg by its ID
     * @param id The product_img_ID
     * @return The ProductImg object or null if not found
     */
    public ProductImg getById(int id) {
        String sql = "SELECT * FROM product_img WHERE product_img_ID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return getFromResultSet(resultSet);
            }
        } catch (SQLException ex) {
            System.out.println("Error getting ProductImg by id: " + ex.getMessage());
        } finally {
            closeResources();
        }
        return null;
    }
}
