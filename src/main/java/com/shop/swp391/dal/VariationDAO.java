/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.shop.swp391.dal;

import com.shop.swp391.entity.Color;
import com.shop.swp391.entity.Size;
import com.shop.swp391.entity.Variation;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author hung
 */
public class VariationDAO extends DBContext implements I_DAO<Variation> {

    @Override
    public List<Variation> findAll() {
        List<Variation> variations = new ArrayList<>();
        String sql = "SELECT * FROM variation";
        try {
            connection = new DBContext().connection;
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                variations.add(getFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return variations;
    }

    @Override
    public boolean update(Variation t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean delete(Variation t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int insert(Variation t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Variation getFromResultSet(ResultSet rs) throws SQLException {
        return new Variation(
                rs.getInt("VariationID"),
                rs.getInt("ProductID"),
                rs.getInt("color_ID"),
                rs.getInt("size_ID"),
                rs.getInt("qty_in_stock"),
                rs.getInt("product_img_ID")
        );
    }

    public List<Color> getAvailableColors(int productId) {
        List<Color> colors = new ArrayList<>();
        String sql = "SELECT DISTINCT c.color_ID, c.color_name FROM variation v "
                + "JOIN color c ON v.color_ID = c.color_ID "
                + "WHERE v.ProductID = ?";

        try {
            connection = new DBContext().getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                colors.add(new Color(resultSet.getInt("color_ID"), resultSet.getString("color_name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return colors;
    }

    public List<Size> getAvailableSizes(int productId) {
        List<Size> sizes = new ArrayList<>();
        String sql = "SELECT DISTINCT s.size_ID, s.size_name FROM variation v "
                + "JOIN size s ON v.size_ID = s.size_ID "
                + "WHERE v.ProductID = ?";

        try {
            connection = new DBContext().getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, productId);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                sizes.add(new Size(resultSet.getInt("size_ID"), resultSet.getString("size_name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sizes;
    }

    public Variation findById(int variationId) {
        Variation variation = null;
        String sql = "SELECT * FROM Variation WHERE variationID = ?";
        try {
            connection = new DBContext().connection;
            statement = connection.prepareStatement(sql);
            statement.setInt(1, variationId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                variation = new Variation(
                    resultSet.getInt("variationID"),
                    resultSet.getInt("productID"),
                    resultSet.getInt("colorID"),
                    resultSet.getInt("sizeID"),
                    resultSet.getInt("qtyInStock"),
                    resultSet.getInt("productImgID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return variation;
    }

    public Variation findByColorIdAndSizeId(int colorId, int sizeId) {
        Variation variation = null;
        String sql = "SELECT * FROM Variation WHERE colorID = ? AND sizeID = ?";
        try {
            connection = new DBContext().connection;
            statement = connection.prepareStatement(sql);
            statement.setInt(1, colorId);
            statement.setInt(2, sizeId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                variation = new Variation(
                    resultSet.getInt("variationID"),
                    resultSet.getInt("productID"),
                    resultSet.getInt("colorID"),
                    resultSet.getInt("sizeID"),
                    resultSet.getInt("qtyInStock"),
                    resultSet.getInt("productImgID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return variation;
    }
}
