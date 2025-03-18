/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.shop.swp391.dal;

import com.shop.swp391.dal.I_DAO;
import com.shop.swp391.config.GlobalConfig;
import com.shop.swp391.entity.User;
import java.sql.PreparedStatement;
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
public class UserDAO extends DBContext implements I_DAO<User> {

    @Override
    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM SWP391_FASHION_SHOP.user";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                users.add(getFromResultSet(resultSet));
            }
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        } finally {
            closeResources();
        }
        return users;
    }

    @Override
    public boolean update(User user) {
        String sql = "UPDATE `SWP391_FASHION_SHOP`.`user`\n"
                + "SET\n"
                + "`UserName` = ?,\n"
                + "`Password` = ?,\n"
                + "`Email` = ?,\n"
                + "`FirstName` = ?,\n"
                + "`LastName` = ?,\n"
                + "`Dob` = ?,\n"
                + "`Sex` = ?,\n"
                + "`Role` = ?,\n"
                + "`Phone` = ?,\n"
                + "`IsActive` = ?\n"
                + "WHERE `UserID` = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getEmail());
            statement.setString(4, user.getFirstName());
            statement.setString(5, user.getLastName());
            statement.setString(6, user.getDob());
            statement.setBoolean(7, user.isSex());
            statement.setInt(8, user.getRoleId());
            statement.setString(9, user.getPhone());
            statement.setBoolean(10, user.isActive());
            statement.setInt(11, user.getId());

            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            System.err.println("Error updating account: " + ex.getMessage());
            return false;
        } finally {
            closeResources();
        }

    }

    @Override
    public boolean delete(User t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int insert(User user) {
        String sql = "INSERT INTO `SWP391_FASHION_SHOP`.`user` ("
            + "`UserName`, "
            + "`Password`, "
            + "`Email`, "
            + "`FirstName`, "
            + "`LastName`, "
            + "`Dob`, "
            + "`Sex`, "
            + "`Role`, "
            + "`Phone`, "
            + "`IsActive`) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getEmail());
            statement.setString(4, user.getFirstName());
            statement.setString(5, user.getLastName());
            statement.setString(6, user.getDob());
            statement.setBoolean(7, user.isSex());
            statement.setInt(8, user.getRoleId());
            statement.setString(9, user.getPhone());
            statement.setBoolean(10, user.isActive());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating account failed, no rows affected.");
            }
            
            resultSet = statement.getGeneratedKeys();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            } else {
                throw new SQLException("Creating account failed, no ID obtained.");
            }
        } catch (Exception ex) {
            System.out.println("Error inserting account: " + ex.getMessage());
            return -1;
        } finally {
            closeResources();
        }
    }

    public User findById(int userId) {
        String sql = "SELECT * FROM SWP391_FASHION_SHOP.user where UserID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return getFromResultSet(resultSet);
            }
        } catch (SQLException ex) {
            System.out.println("Error finding account by id " + ex.getMessage());
        } finally {
            closeResources();
        }
        return null;
    }

    public List<User> findUserWithFilters(String roleFilter, String sexFilter, String statusFilter,
            String searchFilter, int page, int pageSize) {

        List<User> users = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM SWP391_FASHION_SHOP.user where Role != ?");
        List<Object> params = new ArrayList<>();
        params.add(GlobalConfig.ROLE_ADMIN);

        if (roleFilter != null && !roleFilter.isEmpty()) {
            sql.append(" AND Role = ? ");
            params.add(Integer.parseInt(roleFilter));
        }

        if (sexFilter != null && !sexFilter.isEmpty()) {
            sql.append(" AND Sex = ?");
            params.add(sexFilter.equals("1"));
        }

        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" AND IsActive = ?");
            params.add(statusFilter.equals("1"));
        }

        if (searchFilter != null && !searchFilter.trim().isEmpty()) {
            sql.append(" AND Email LIKE ? OR Phone LIKE ? OR FirstName LIKE ? OR LastName LIKE ?");
            String searchPatterns = "%" + searchFilter.trim() + "%";
            params.add(searchPatterns);
            params.add(searchPatterns);
            params.add(searchPatterns);
            params.add(searchPatterns);
        }

        sql.append(" ORDER BY UserID LIMIT ? OFFSET ?");
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
                users.add(getFromResultSet(resultSet));

            }
        } catch (SQLException ex) {
            System.out.println("Error finding filtered users: " + ex.getMessage());
        } finally {
            closeResources();
        }
        return users;
    }

    public int getTotalFilteredAccounts(String roleFilter, String sexFilter, String statusFilter,
            String searchFilter) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM SWP391_FASHION_SHOP.user where Role != ?");
        List<Object> params = new ArrayList<>();
        params.add(GlobalConfig.ROLE_ADMIN);

        if (roleFilter != null && !roleFilter.isEmpty()) {
            sql.append(" AND Role = ?");
            params.add(Integer.parseInt(roleFilter));
        }

        if (sexFilter != null && !sexFilter.isEmpty()) {
            sql.append(" AND Sex = ?");
            params.add(sexFilter.equals("1"));
        }

        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" AND IsActive = ?");
            params.add(statusFilter.equals("1"));
        }

        if (searchFilter != null && !searchFilter.trim().isEmpty()) {
            sql.append(" AND Email LIKE ? OR Phone LIKE ? OR FirstName LIKE ? OR LastName LIKE ?");
            String searchPattern = "%" + searchFilter.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
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
            System.out.println("Error counting filtered users: " + ex.getMessage());
        } finally {
            closeResources();
        }
        return 0;
    }

    public boolean deactivateAccount(int userID) {
        String sql = "UPDATE SWP391_FASHION_SHOP.user SET IsActive = 0 WHERE UserID = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, userID);
            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (Exception ex) {
            System.out.println("Error deactivating account: " + ex.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }

    public User findByEmailOrUsernameAndPass(User account) {
        String sql = "SELECT * FROM SWP391_FASHION_SHOP.user WHERE (Email = ? OR UserName = ?) AND Password = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, account.getEmail());
            statement.setString(2, account.getUsername());
            statement.setString(3, account.getPassword());
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return getFromResultSet(resultSet);
            }
        } catch (SQLException ex) {
            System.err.println("Error finding user by email/username and password: " + ex.getMessage());
        } finally {
            closeResources();
        }
        return null;
    }
    
    public User findByEmail(User account) {
        String sql = "SELECT * FROM SWP391_FASHION_SHOP.user WHERE Email = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, account.getEmail());
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return getFromResultSet(resultSet);
            }
        } catch (SQLException ex) {
            System.err.println("Error finding user by email: " + ex.getMessage());
        } finally {
            closeResources();
        }
        return null;
    }
    

    public boolean updatePassword(User account) {
        String sql = "UPDATE SWP391_FASHION_SHOP.user SET Password = ? WHERE Email = ? OR UserName = ?";
        try {
            connection = getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, account.getPassword()); // Cần mã hóa mật khẩu trước khi lưu
            statement.setString(2, account.getEmail());
            statement.setString(3, account.getUsername());
    
            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            System.err.println("Error updating password: " + ex.getMessage());
            return false;
        } finally {
            closeResources();
        }
    }
    

    @Override
    public User getFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("UserID"));
        user.setUsername(rs.getString("UserName"));
        user.setPassword(rs.getString("Password"));
        user.setEmail(rs.getString("Email"));
        user.setFirstName(rs.getString("FirstName"));
        user.setLastName(rs.getString("LastName"));
        user.setDob(rs.getString("Dob"));
        user.setSex(rs.getBoolean("Sex"));
        user.setRoleId(rs.getInt("Role"));
        user.setPhone(rs.getString("Phone"));
        user.setActive(rs.getBoolean("IsActive"));
        return user;
    }

}
