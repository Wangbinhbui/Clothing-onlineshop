package com.shop.swp391.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Collection {
    private int collectionID;
    private String collectionName;
    private String collectionImg;
    private String collectionDescription;
    private Date createDate;
    private int promotionID;

} 
