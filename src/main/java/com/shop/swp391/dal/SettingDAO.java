/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.shop.swp391.dal;

import com.shop.swp391.dal.DBContext;
import com.shop.swp391.dal.I_DAO;
import com.shop.swp391.config.GlobalConfig;
import com.shop.swp391.entity.Setting;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class SettingDAO extends DBContext implements I_DAO<Setting> {

    public List<Setting> findAll() {
        List<Setting> setting = new ArrayList<>();
        String sql = "SELECT * FROM SWP391_FASHION_SHOP.setting";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                setting.add(getFromResultSet(resultSet));
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        } finally {
            closeResources();
        }
        return setting;
    }

    @Override
    public boolean update(Setting setting) {
        String sql = "UPDATE `SWP391_FASHION_SHOP`.`setting`\n"
            + "SET\n"
            + "`type` = ?,\n"
            + "`value` = ?,\n"
            + "`order` = ?,\n"
            + "`status` = ?\n" 
            + "WHERE `id` = ?;";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, setting.getType());
            statement.setString(2, setting.getValue());
            statement.setInt(3, setting.getOrder());
            statement.setString(4, setting.getStatus());
            statement.setInt(5, setting.getId());

            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            System.err.println("Error updating setting: " + ex.getMessage());
            return false;
        } finally {
            closeResources();
        }

    }

    @Override
    public boolean delete(Setting setting) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int insert(Setting setting) {
        String sql = "INSERT INTO `SWP391_FASHION_SHOP`.`setting` ("
                + "`type`, "
                + "`value`, "
                + "`order`, "
                + "`status`) "
                + "VALUES (?, ?, ?, ?);";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, setting.getType());
            statement.setString(2, setting.getValue());
            statement.setInt(3, setting.getOrder());
            statement.setString(4, setting.getStatus());

            int affectedRows = statement.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating setting failed, no rows affected.");
            }

            resultSet = statement.getGeneratedKeys();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            } else {
                throw new SQLException("Creating setting failed, no ID obtained.");
            }
        } catch (Exception ex) {
            System.out.println("Error inserting setting: " + ex.getMessage());
            return -1;
        } finally {
            closeResources();
        }
    }

    public Setting findById(int settingId) {
        String sql = "SELECT * FROM SWP391_FASHION_SHOP.setting where id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, settingId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return getFromResultSet(resultSet);
            }
        } catch (SQLException ex) {
            System.out.println("Error finding setting by id " + ex.getMessage());
        } finally {
            closeResources();
        }
        return null;
    }

    public List<Setting> findSettingWithFilters(String typeFilter, String statusFilter,
            String searchFilter, int page, int pageSize) {

        List<Setting> settings = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM SWP391_FASHION_SHOP.setting WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (typeFilter != null && !typeFilter.isEmpty()) {
            sql.append(" AND type = ? ");
            params.add(typeFilter);
        }

        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(statusFilter);
        }

        if (searchFilter != null && !searchFilter.trim().isEmpty()) {
            sql.append(" AND value LIKE ?");
            String searchPatterns = "%" + searchFilter.trim() + "%";
            params.add(searchPatterns);
        }

        sql.append(" ORDER BY id LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                statement.setObject(i + 1, params.get(i));
            }
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                settings.add(getFromResultSet(resultSet));
            }
        } catch (SQLException ex) {
            System.out.println("Error finding filtered settings: " + ex.getMessage());
        } finally {
            closeResources();
        }
        return settings;
    }

    public int getTotalFilteredSettings(String typeFilter, String statusFilter,String searchFilter) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM SWP391_FASHION_SHOP.setting WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (typeFilter != null && !typeFilter.isEmpty()) {
            sql.append(" AND type = ? ");
            params.add(typeFilter);
        }

        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" AND status = ?");
            params.add(statusFilter);
        }

        if (searchFilter != null && !searchFilter.trim().isEmpty()) {
            sql.append(" AND value LIKE ?");
            String searchPatterns = "%" + searchFilter.trim() + "%";
            params.add(searchPatterns);
        }

        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                statement.setObject(i + 1, params.get(i));
            }
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (Exception ex) {
            System.out.println("Error counting filtered settings: " + ex.getMessage());
        } finally {
            closeResources();
        }
        return 0;
    }
    
    public boolean deactivateSetting(int settingId) {
        String sql = "UPDATE SWP391_FASHION_SHOP.setting SET status = 'Inactive' WHERE id = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, settingId);
            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (Exception ex) {
            System.out.println("Error deactivating setting: " + ex.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }

    @Override
    public Setting getFromResultSet(ResultSet rs) throws SQLException {
        Setting setting = new Setting();
        setting.setId(rs.getInt("id"));
        setting.setType(rs.getString("type"));
        setting.setValue(rs.getString("value"));
        setting.setOrder(rs.getInt("order"));
        setting.setStatus(rs.getString("status"));
        setting.setCreatedAt(rs.getString("created_at"));
        setting.setUpdatedAt(rs.getString("updated_at"));
        return setting;
    }

    

}
