package com.shop.swp391.dal;

import com.shop.swp391.entity.BlogCategory;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BlogCategoryDAO extends DBContext implements I_DAO<BlogCategory> {

    @Override
    public List<BlogCategory> findAll() {
        List<BlogCategory> categories = new ArrayList<>();
        String sql = "SELECT * FROM blog_category";
        try {
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                categories.add(getFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            Logger.getLogger(BlogCategoryDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources();
        }
        return categories;
    }

    @Override
    public boolean update(BlogCategory category) {
        String sql = "UPDATE blog_category SET name = ?, description = ? WHERE id = ?";
        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, category.getName());
            statement.setString(2, category.getDescription());
            statement.setInt(3, category.getId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(BlogCategoryDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources();
        }
        return false;
    }

    @Override
    public boolean delete(BlogCategory category) {
        String sql = "DELETE FROM blog_category WHERE id = ?";
        try {
            statement = connection.prepareStatement(sql);
            statement.setInt(1, category.getId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(BlogCategoryDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources();
        }
        return false;
    }

    @Override
    public int insert(BlogCategory category) {
        String sql = "INSERT INTO blog_category (name, description) VALUES (?, ?)";
        try {
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, category.getName());
            statement.setString(2, category.getDescription());
            int affectedRows = statement.executeUpdate();

            if (affectedRows > 0) {
                resultSet = statement.getGeneratedKeys();
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(BlogCategoryDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources();
        }
        return -1;
    }

    @Override
    public BlogCategory getFromResultSet(ResultSet resultSet) throws SQLException {
        return new BlogCategory(
            resultSet.getInt("id"),
            resultSet.getString("name"),
            resultSet.getString("description"),
            resultSet.getTimestamp("created_at").toLocalDateTime(),
            resultSet.getTimestamp("updated_at").toLocalDateTime()
        );
    }

    public BlogCategory findById(int id) {
        String sql = "SELECT * FROM blog_category WHERE id = ?";
        try {
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return getFromResultSet(resultSet);
            }
        } catch (SQLException e) {
            Logger.getLogger(BlogCategoryDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources();
        }
        return null;
    }
}
