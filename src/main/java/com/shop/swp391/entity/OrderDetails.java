package com.shop.swp391.entity;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderDetails {
    private int orderDetailID;
    private int productID;
    private int orderID;
    private int quantity;
    private double price;
    private String orderDate;
    private int variationID;
}
