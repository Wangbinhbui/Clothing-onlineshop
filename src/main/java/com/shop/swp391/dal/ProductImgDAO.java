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
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public boolean delete(ProductImg t) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public int insert(ProductImg productImg) {
        String sql = "INSERT INTO product_img (thumbnail, product_img_1, product_img_2, product_img_3, product_img_name) "
                   + "VALUES (?, ?, ?, ?, ?)";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, productImg.getThumbnail());
            statement.setString(2, productImg.getProductImg1());
            statement.setString(3, productImg.getProductImg2());
            statement.setString(4, productImg.getProductImg3());
            statement.setString(5, productImg.getProductImgName());
            
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
        String sql = "SELECT thumbnail FROM product_img WHERE ProductID = ? LIMIT 1";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("thumbnail");
            }
        } catch (SQLException ex) {
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
        String sql = "SELECT thumbnail, product_img_1, product_img_2, product_img_3 FROM product_img WHERE ProductID = ?";
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
}
