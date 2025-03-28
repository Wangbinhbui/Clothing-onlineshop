package com.shop.swp391.dal;

import com.shop.swp391.entity.Country;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Country entity
 */
public class CountryDAO extends DBContext implements I_DAO<Country> {

    @Override
    public List<Country> findAll() {
        List<Country> countries = new ArrayList<>();
        String query = "SELECT CountryID, CountryName FROM country";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                countries.add(getFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all countries: " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return countries;
    }
    
    public Country findById(int countryID) {
        String query = "SELECT CountryID, CountryName FROM country WHERE CountryID = ?";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, countryID);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                return getFromResultSet(resultSet);
            }
        } catch (SQLException e) {
            System.err.println("Error getting country by ID " + countryID + ": " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return null;
    }
    
    @Override
    public int insert(Country country) {
        String query = "INSERT INTO country (CountryName) VALUES (?)";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query, java.sql.Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, country.getCountryName());
            
            int affectedRows = statement.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating country failed, no rows affected.");
            }
            
            resultSet = statement.getGeneratedKeys();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            } else {
                throw new SQLException("Creating country failed, no ID obtained.");
            }
        } catch (SQLException e) {
            System.err.println("Error adding country: " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return -1;
    }
    
    @Override
    public boolean update(Country country) {
        String query = "UPDATE country SET CountryName = ? WHERE CountryID = ?";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, country.getCountryName());
            statement.setInt(2, country.getCountryID());
            
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating country: " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return false;
    }
    
    @Override
    public boolean delete(Country country) {
        return deleteById(country.getCountryID());
    }
    
    public boolean deleteById(int countryID) {
        String query = "DELETE FROM country WHERE CountryID = ?";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, countryID);
            
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting country: " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return false;
    }
    
    @Override
    public Country getFromResultSet(ResultSet rs) throws SQLException {
        return new Country(
            rs.getInt("CountryID"),
            rs.getString("CountryName")
        );
    }
    
    /**
     * Main method to test CountryDAO functionality
     */
    public static void main(String[] args) {
        CountryDAO countryDAO = new CountryDAO();
        
        System.out.println("===== Testing CountryDAO Connection =====");
        
        // Test findAll method
        System.out.println("\n----- Testing findAll() -----");
        List<Country> countries = countryDAO.findAll();
        if (countries.isEmpty()) {
            System.out.println("No countries found in database.");
        } else {
            System.out.println("Found " + countries.size() + " countries:");
            for (Country country : countries) {
                System.out.println(country.getCountryID() + ": " + country.getCountryName());
            }
        }
        
        // Test findById method
        System.out.println("\n----- Testing findById() -----");
        if (!countries.isEmpty()) {
            int firstCountryId = countries.get(0).getCountryID();
            Country country = countryDAO.findById(firstCountryId);
            if (country != null) {
                System.out.println("Found country with ID " + firstCountryId + ": " + country.getCountryName());
            } else {
                System.out.println("Country with ID " + firstCountryId + " not found.");
            }
        }
        
        // Test insert method
        System.out.println("\n----- Testing insert() -----");
        Country newCountry = new Country(0, "Test Country");
        int newId = countryDAO.insert(newCountry);
        if (newId > 0) {
            System.out.println("Successfully inserted new country with ID: " + newId);
            
            // Test update method
            System.out.println("\n----- Testing update() -----");
            newCountry.setCountryID(newId);
            newCountry.setCountryName("Updated Test Country");
            boolean updateResult = countryDAO.update(newCountry);
            System.out.println("Update result: " + (updateResult ? "Success" : "Failed"));
            
            // Test delete method
            System.out.println("\n----- Testing delete() -----");
            boolean deleteResult = countryDAO.deleteById(newId);
            System.out.println("Delete result: " + (deleteResult ? "Success" : "Failed"));
        } else {
            System.out.println("Failed to insert new country.");
        }
        
        System.out.println("\n===== CountryDAO Testing Complete =====");
    }
} 