package com.shop.swp391.dal;

import com.shop.swp391.entity.Story;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class StoryDAO extends DBContext implements I_DAO<Story> {

    @Override
    public List<Story> findAll() {
        List<Story> stories = new ArrayList<>();
        String sql = "SELECT * FROM story";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                stories.add(getFromResultSet(resultSet));
            }
        } catch (SQLException ex) {
            System.out.println("Error finding stories: " + ex.getMessage());
        } finally {
            closeResources();
        }
        return stories;
    }

    @Override
    public boolean update(Story story) {
        String sql = "UPDATE story SET title = ?, thumbnail = ?, backlink = ?, status = ?, description = ? WHERE story_id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, story.getTitle());
            statement.setString(2, story.getThumbnail());
            statement.setString(3, story.getBacklink());
            statement.setString(4, story.getStatus());
            statement.setString(5, story.getDescription());
            statement.setInt(6, story.getStoryId());

            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            System.out.println("Error updating story: " + ex.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }

    @Override
    public boolean delete(Story story) {
    String sql = "DELETE FROM story WHERE story_id = ?";
    try {
        connection = getConnection();
        statement = connection.prepareStatement(sql);
        statement.setInt(1, story.getStoryId());

        int affectedRows = statement.executeUpdate();
        System.out.println("Delete Query: " + sql + " with story_id=" + story.getStoryId());
        System.out.println("Rows affected: " + affectedRows);
        
        return affectedRows > 0;
    } catch (SQLException ex) {
        System.out.println("Error deleting story: " + ex.getMessage());
        return false;
    } finally {
        closeResources();
    }
}


    @Override
    public int insert(Story story) {
        String sql = "INSERT INTO story (title, thumbnail, backlink, status, description) VALUES (?, ?, ?, ?, ?)";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            statement.setString(1, story.getTitle());
            statement.setString(2, story.getThumbnail());
            statement.setString(3, story.getBacklink());
            statement.setString(4, story.getStatus() != null ? story.getStatus() : "Active");
            statement.setString(5, story.getDescription());

            int affectedRows = statement.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating story failed, no rows affected.");
            }

            resultSet = statement.getGeneratedKeys();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            } else {
                throw new SQLException("Creating story failed, no ID obtained.");
            }
        } catch (SQLException ex) {
            System.out.println("Error inserting story: " + ex.getMessage());
            return -1;
        } finally {
            closeResources();
        }
    }

    @Override
    public Story getFromResultSet(ResultSet rs) throws SQLException {
        return Story.builder()
                .storyId(rs.getInt("story_id"))
                .title(rs.getString("title"))
                .thumbnail(rs.getString("thumbnail"))
                .backlink(rs.getString("backlink"))
                .status(rs.getString("status"))
                .description(rs.getString("description"))
                .build();
    }

    public Story findById(int id) {
        String sql = "SELECT * FROM story WHERE story_id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return getFromResultSet(resultSet);
            }
        } catch (SQLException ex) {
            System.out.println("Error finding story by ID: " + ex.getMessage());
        } finally {
            closeResources();
        }
        return null;
    }

    public List<Story> findActiveStories() {
        List<Story> stories = new ArrayList<>();
        String sql = "SELECT * FROM story WHERE status = 'Active' ORDER BY story_id DESC";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                stories.add(getFromResultSet(resultSet));
            }
        } catch (SQLException ex) {
            System.out.println("Error finding active stories: " + ex.getMessage());
        } finally {
            closeResources();
        }
        return stories;
    }

    public List<Story> findStoriesWithFilters(String searchFilter, String statusFilter, int page, int pageSize) {
        List<Story> stories = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM story WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Add search filter
        if (searchFilter != null && !searchFilter.trim().isEmpty()) {
            sql.append(" AND (title LIKE ? OR description LIKE ?)");
            String searchPattern = "%" + searchFilter.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
        }

        // Add status filter
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append(" AND status = ?");
            params.add(statusFilter);
        }

        // Add pagination
        sql.append(" ORDER BY story_id DESC LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql.toString());

            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                statement.setObject(i + 1, params.get(i));
            }

            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                stories.add(getFromResultSet(resultSet));
            }
        } catch (SQLException ex) {
            System.out.println("Error finding stories with filters: " + ex.getMessage());
        } finally {
            closeResources();
        }
        return stories;
    }

    public int getTotalStories(String searchFilter, String statusFilter) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM story WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Add search filter
        if (searchFilter != null && !searchFilter.trim().isEmpty()) {
            sql.append(" AND (title LIKE ? OR description LIKE ?)");
            String searchPattern = "%" + searchFilter.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
        }

        // Add status filter
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append(" AND status = ?");
            params.add(statusFilter);
        }

        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql.toString());

            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                statement.setObject(i + 1, params.get(i));
            }

            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException ex) {
            System.out.println("Error getting total stories: " + ex.getMessage());
        } finally {
            closeResources();
        }
        return 0;
    }
}
