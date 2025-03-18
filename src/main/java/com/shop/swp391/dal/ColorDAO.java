/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.shop.swp391.dal;

import com.shop.swp391.entity.Color;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hung
 */
public class ColorDAO extends DBContext implements I_DAO<Color> {

    @Override
    public List<Color> findAll() {
        List<Color> colors = new ArrayList<>();
        String sql = "SELECT * FROM color";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                colors.add(getFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return colors;
    }

    @Override
    public boolean update(Color t) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public boolean delete(Color t) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public int insert(Color t) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Color getFromResultSet(ResultSet rs) throws SQLException {
        return new Color(
            rs.getInt("color_ID"),
            rs.getString("color_name")
        );
    }
    
    public Color findById(int id) {
        Color color = null;
        String sql = "SELECT * FROM color WHERE color_ID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                color = getFromResultSet(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return color;
    }
}
