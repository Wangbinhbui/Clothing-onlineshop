/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.shop.swp391.dal;

import com.shop.swp391.entity.Blog;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BlogDAO extends DBContext implements I_DAO<Blog> {

    @Override
    public List<Blog> findAll() {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT * FROM blog";

        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                blogs.add(getFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources();
        }
        return blogs;
    }

    @Override
    public boolean update(Blog blog) {
        String sql = "UPDATE blog SET title = ?, thumbnail = ?, brief_info = ?, content = ?, category_id = ?, author = ?, status = ? WHERE id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, blog.getTitle());
            statement.setString(2, blog.getThumbnail());
            statement.setString(3, blog.getBriefInfo());
            statement.setString(4, blog.getContent());
            statement.setInt(5, blog.getCategoryId());
            statement.setInt(6, blog.getAuthor());
            statement.setString(7, blog.getStatus());
            statement.setInt(8, blog.getId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources();
        }
        return false;
    }

    @Override
    public boolean delete(Blog blog) {
        String sql = "DELETE FROM blog WHERE id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, blog.getId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources();
        }
        return false;
    }

    @Override
    public int insert(Blog blog) {
        String sql = "INSERT INTO blog (title, thumbnail, brief_info, content, category_id, author, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, blog.getTitle());
            statement.setString(2, blog.getThumbnail());
            statement.setString(3, blog.getBriefInfo());
            statement.setString(4, blog.getContent());
            statement.setInt(5, blog.getCategoryId());
            statement.setInt(6, blog.getAuthor());
            statement.setString(7, blog.getStatus());
            int affectedRows = statement.executeUpdate();

            if (affectedRows > 0) {
                resultSet = statement.getGeneratedKeys();
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources();
        }
        return -1;
    }

    @Override
    public Blog getFromResultSet(ResultSet resultSet) throws SQLException {
        return new Blog(
            resultSet.getInt("id"),
            resultSet.getString("title"),
            resultSet.getString("thumbnail"),
            resultSet.getString("brief_info"),
            resultSet.getString("content"),
            resultSet.getInt("category_id"),
            resultSet.getInt("author"),
            resultSet.getTimestamp("updated_date").toLocalDateTime(),
            resultSet.getTimestamp("created_date").toLocalDateTime(),
            resultSet.getString("status")
        );
    }

    public Blog findById(int id) {
        String sql = "SELECT * FROM blog WHERE id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return getFromResultSet(resultSet);
            }
        } catch (SQLException e) {
            Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources();
        }
        return null;
    }
}

