package com.shop.swp391.entity;

import java.util.Date;

/**
 *
 * @author PC
 */
public class Collection {
    private int collectionID;
    private String collectionName;
    private String collectionImg;
    private String collectionDescription;
    private Date createDate;
    private int promotionID;

    public Collection() {
    }

    public Collection(int collectionID, String collectionName, String collectionImg, String collectionDescription, Date createDate, int promotionID) {
        this.collectionID = collectionID;
        this.collectionName = collectionName;
        this.collectionImg = collectionImg;
        this.collectionDescription = collectionDescription;
        this.createDate = createDate;
        this.promotionID = promotionID;
    }

    public int getCollectionID() {
        return collectionID;
    }

    public void setCollectionID(int collectionID) {
        this.collectionID = collectionID;
    }

    public String getCollectionName() {
        return collectionName;
    }

    public void setCollectionName(String collectionName) {
        this.collectionName = collectionName;
    }

    public String getCollectionImg() {
        return collectionImg;
    }

    public void setCollectionImg(String collectionImg) {
        this.collectionImg = collectionImg;
    }

    public String getCollectionDescription() {
        return collectionDescription;
    }

    public void setCollectionDescription(String collectionDescription) {
        this.collectionDescription = collectionDescription;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public int getPromotionID() {
        return promotionID;
    }

    public void setPromotionID(int promotionID) {
        this.promotionID = promotionID;
    }
} 