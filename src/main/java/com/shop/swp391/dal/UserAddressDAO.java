package com.shop.swp391.dal;

import com.shop.swp391.entity.UserAddress;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for UserAddress entity
 */
public class UserAddressDAO extends DBContext {
    
    /**
     * Insert a new user-address relationship
     * @param userID The user ID
     * @param addressID The address ID
     * @return true if successful, false otherwise
     */
    public boolean insert(int userID, int addressID) {
        String query = "INSERT INTO useraddress (UserID, AddressID) VALUES (?, ?)";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, userID);
            statement.setInt(2, addressID);
            
            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("Error adding user address: " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return false;
    }
    
    /**
     * Insert a new user-address relationship
     * @param userAddress The UserAddress object
     * @return true if successful, false otherwise
     */
    public boolean insert(UserAddress userAddress) {
        return insert(userAddress.getUserID(), userAddress.getAddressID());
    }
    
    /**
     * Get all addresses for a user
     * @param userID The user ID
     * @return List of address IDs
     */
    public List<Integer> getAddressIDsByUserID(int userID) {
        List<Integer> addressIDs = new ArrayList<>();
        String query = "SELECT AddressID FROM useraddress WHERE UserID = ?";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, userID);
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                addressIDs.add(resultSet.getInt("AddressID"));
            }
        } catch (SQLException e) {
            System.err.println("Error getting addresses for user ID " + userID + ": " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return addressIDs;
    }
    
    /**
     * Delete a user-address relationship
     * @param userID The user ID
     * @param addressID The address ID
     * @return true if successful, false otherwise
     */
    public boolean delete(int userID, int addressID) {
        String query = "DELETE FROM useraddress WHERE UserID = ? AND AddressID = ?";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, userID);
            statement.setInt(2, addressID);
            
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting user address: " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return false;
    }
    
    /**
     * Delete all addresses for a user
     * @param userID The user ID
     * @return true if successful, false otherwise
     */
    public boolean deleteAllForUser(int userID) {
        String query = "DELETE FROM useraddress WHERE UserID = ?";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, userID);
            
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting all addresses for user ID " + userID + ": " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return false;
    }
    
    /**
     * Get UserAddress from ResultSet
     * @param rs The ResultSet
     * @return UserAddress object
     * @throws SQLException if an error occurs
     */
    public UserAddress getFromResultSet(ResultSet rs) throws SQLException {
        UserAddress userAddress = new UserAddress();
        userAddress.setUserID(rs.getInt("UserID"));
        userAddress.setAddressID(rs.getInt("AddressID"));
        return userAddress;
    }
} 