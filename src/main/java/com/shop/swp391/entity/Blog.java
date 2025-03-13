/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.shop.swp391.entity;

import java.time.LocalDateTime;

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

}