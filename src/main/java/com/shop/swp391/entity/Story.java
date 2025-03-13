/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.shop.swp391.entity;

/**
 *
 * @author Quang
 */
import lombok.*;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.io.Serializable;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Story implements Serializable {

    private int storyId;
    private String thumbnail;
    private String title;
    private String description;
    private String backlink;
    private String status;

}
