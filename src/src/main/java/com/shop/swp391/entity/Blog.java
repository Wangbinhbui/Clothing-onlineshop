/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.shop.swp391.entity;

import java.time.LocalDateTime;

public class Blog {
    private int id;
    private String title;
    private String thumbnail;
    private String briefInfo;
    private String content;
    private int categoryId;
    private int author;
    private LocalDateTime updatedDate;
    private LocalDateTime createdDate;
    private String status; // "Active" hoặc "Inactive"

    public Blog() {}

    public Blog(int id, String title, String thumbnail, String briefInfo, String content, int categoryId, int author,
                LocalDateTime updatedDate, LocalDateTime createdDate, String status) {
        this.id = id;
        this.title = title;
        this.thumbnail = thumbnail;
        this.briefInfo = briefInfo;
        this.content = content;
        this.categoryId = categoryId;
        this.author = author;
        this.updatedDate = updatedDate;
        this.createdDate = createdDate;
        this.status = status;
    }

    public Blog(String title, String string, String string0, String content, int i, int i0, String active) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public Blog(int id, String title, String string, String string0, String content, int i, int i0, String active) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getBriefInfo() {
        return briefInfo;
    }

    public void setBriefInfo(String briefInfo) {
        this.briefInfo = briefInfo;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getAuthor() {
        return author;
    }

    public void setAuthor(int author) {
        this.author = author;
    }

    public LocalDateTime getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(LocalDateTime updatedDate) {
        this.updatedDate = updatedDate;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}

