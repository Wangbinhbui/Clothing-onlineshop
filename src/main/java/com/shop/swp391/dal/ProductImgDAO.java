/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.shop.swp391.dal;

import com.shop.swp391.entity.ProductImg;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Statement;

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
            connection = new DBContext().connection;
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
        return new ProductImg(
                rs.getInt("product_img_ID"),
                rs.getString("thumbnail"),
                rs.getString("product_img_1"),
                rs.getString("product_img_2"),
                rs.getString("product_img_3"),
                rs.getString("product_img_name")
        );
    }

    public String getProductThumbnail(int productId) {
       String sql = "SELECT pi.thumbnail FROM product_img pi " +
                 "JOIN variation v ON pi.product_img_ID = v.product_img_ID " +
                 "WHERE v.ProductID = ? LIMIT 1"; 
        try {
            connection = new DBContext().getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return "assets/home/images/product/" + resultSet.getString("thumbnail"); 
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            closeResources();
        }
        return "assets/home/images/product/default.jpg";
    }

    public static void main(String[] args) {
        ProductImgDAO productImgDAO = new ProductImgDAO();
        int testProductId = 15;
        for (int i = 0; i < 72; i++) {
            String imagePath = productImgDAO.getProductThumbnail(i);
            System.out.println("Image path for ProductImgID " + testProductId + ": " + imagePath);
        }
    }

}
