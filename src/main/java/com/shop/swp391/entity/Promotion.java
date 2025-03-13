package com.shop.swp391.entity;

import lombok.*;

import java.util.Date;

@ToString
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Promotion {
    private int promotionId;
    private String promotionName;
    private String promotionDescription;
    private double discountRate;
    private Date startDate;
    private Date endDate;
    private String backgroundColor;
}
