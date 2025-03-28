package com.shop.swp391.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Entity class representing the Country table in the database
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Country {
    private int countryID;
    private String countryName;
} 