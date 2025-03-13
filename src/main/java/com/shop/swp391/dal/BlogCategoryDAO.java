package com.shop.swp391.dal;

import com.shop.swp391.entity.Blog;
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
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                categories.add(getFromResultSet(rs));
            }
        } catch (SQLException e) {
            Logger.getLogger(BlogCategoryDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return categories;
    }

    @Override
    public boolean update(BlogCategory category) {
        String sql = "UPDATE blog_category SET name = ?, description = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category.getName());
            stmt.setString(2, category.getDescription());
            stmt.setInt(3, category.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(BlogCategoryDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public boolean delete(BlogCategory category) {
        String sql = "DELETE FROM blog_category WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, category.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(BlogCategoryDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    @Override
    public int insert(BlogCategory category) {
        String sql = "INSERT INTO blog_category (name, description) VALUES (?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, category.getName());
            stmt.setString(2, category.getDescription());
            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(BlogCategoryDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return -1;
    }

    @Override
    public BlogCategory getFromResultSet(ResultSet rs) throws SQLException {
        return new BlogCategory(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getString("description"),
            rs.getTimestamp("created_at").toLocalDateTime(),
            rs.getTimestamp("updated_at").toLocalDateTime()
        );
    }

    public BlogCategory findById(int id) {
        String sql = "SELECT * FROM blog_category WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return getFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(BlogCategoryDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }

    @Override
    public boolean delete(Blog t) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
