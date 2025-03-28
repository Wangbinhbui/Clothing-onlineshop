package com.shop.swp391.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Entity class representing the Address table in the database
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Address {
    private int addressID;
    private String addressLine;
    private String city;
    private String postalCode;
    private int countryID;
    
    // Optional: Include Country object for relationship
    private Country country;
    
    // Constructor without the Country object
    public Address(int addressID, String addressLine, String city, String postalCode, int countryID) {
        this.addressID = addressID;
        this.addressLine = addressLine;
        this.city = city;
        this.postalCode = postalCode;
        this.countryID = countryID;
    }
} 