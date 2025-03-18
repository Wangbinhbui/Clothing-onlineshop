/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.shop.swp391.dal;

import com.shop.swp391.entity.Size;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hung
 */
public class SizeDAO extends DBContext implements I_DAO<Size>{

    @Override
    public List<Size> findAll() {
        List<Size> sizes = new ArrayList<>();
        String sql = "SELECT * FROM size";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                sizes.add(getFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return sizes;
    }

    @Override
    public boolean update(Size t) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public boolean delete(Size t) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public int insert(Size t) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public Size getFromResultSet(ResultSet rs) throws SQLException {
        return new Size(
            rs.getInt("size_ID"),
            rs.getString("size_name")
        );
    }
    
    public Size findById(int id) {
        Size size = null;
        String sql = "SELECT * FROM size WHERE size_ID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                size = getFromResultSet(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return size;
    }
}
