package com.shop.swp391.dal;

import com.shop.swp391.entity.Address;
import com.shop.swp391.entity.Country;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Address entity
 */
public class AddressDAO extends DBContext implements I_DAO<Address> {
    private CountryDAO countryDAO;
    
    public AddressDAO() {
        this.countryDAO = new CountryDAO();
    }

    @Override
    public List<Address> findAll() {
        return getAllAddresses(false);
    }
    
    /**
     * Get all addresses from the database
     * @param includeCountry Whether to include the Country object in the results
     * @return List of Address objects
     */
    public List<Address> getAllAddresses(boolean includeCountry) {
        List<Address> addresses = new ArrayList<>();
        String query = "SELECT AddressID, addressline, city, postalcode, CountryID FROM address";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Address address = getFromResultSet(resultSet);
                
                if (includeCountry) {
                    address.setCountry(countryDAO.findById(address.getCountryID()));
                }
                
                addresses.add(address);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all addresses: " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return addresses;
    }
    
    /**
     * Get an address by its ID
     * @param addressID The ID of the address to retrieve
     * @param includeCountry Whether to include the Country object in the result
     * @return Address object if found, null otherwise
     */
    public Address findById(int addressID, boolean includeCountry) {
        String query = "SELECT AddressID, addressline, city, postalcode, CountryID FROM address WHERE AddressID = ?";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, addressID);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                Address address = getFromResultSet(resultSet);
                
                if (includeCountry) {
                    address.setCountry(countryDAO.findById(address.getCountryID()));
                }
                
                return address;
            }
        } catch (SQLException e) {
            System.err.println("Error getting address by ID " + addressID + ": " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return null;
    }
    
    @Override
    public int insert(Address address) {
        String query = "INSERT INTO address (addressline, city, postalcode, CountryID) VALUES (?, ?, ?, ?)";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query, java.sql.Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, address.getAddressLine());
            statement.setString(2, address.getCity());
            statement.setString(3, address.getPostalCode());
            statement.setInt(4, address.getCountryID());
            
            int affectedRows = statement.executeUpdate();
            if (affectedRows > 0) {
                resultSet = statement.getGeneratedKeys();
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error adding address: " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return -1;
    }
    
    @Override
    public boolean update(Address address) {
        String query = "UPDATE address SET addressline = ?, city = ?, postalcode = ?, CountryID = ? WHERE AddressID = ?";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setString(1, address.getAddressLine());
            statement.setString(2, address.getCity());
            statement.setString(3, address.getPostalCode());
            statement.setInt(4, address.getCountryID());
            statement.setInt(5, address.getAddressID());
            
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating address: " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return false;
    }
    
    @Override
    public boolean delete(Address address) {
        return deleteById(address.getAddressID());
    }
    
    public boolean deleteById(int addressID) {
        String query = "DELETE FROM address WHERE AddressID = ?";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, addressID);
            
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting address: " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return false;
    }
    
    /**
     * Get addresses by country ID
     * @param countryID The country ID to filter by
     * @param includeCountry Whether to include the Country object in the results
     * @return List of Address objects
     */
    public List<Address> getAddressesByCountryId(int countryID, boolean includeCountry) {
        List<Address> addresses = new ArrayList<>();
        String query = "SELECT AddressID, addressline, city, postalcode, CountryID FROM address WHERE CountryID = ?";
        
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, countryID);
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Address address = getFromResultSet(resultSet);
                
                if (includeCountry) {
                    address.setCountry(countryDAO.findById(address.getCountryID()));
                }
                
                addresses.add(address);
            }
        } catch (SQLException e) {
            System.err.println("Error getting addresses by country ID " + countryID + ": " + e.getMessage());
        } finally {
            closeResources();
        }
        
        return addresses;
    }
    
    @Override
    public Address getFromResultSet(ResultSet rs) throws SQLException {
        return new Address(
            rs.getInt("AddressID"),
            rs.getString("addressline"),
            rs.getString("city"),
            rs.getString("postalcode"),
            rs.getInt("CountryID")
        );
    }
} 