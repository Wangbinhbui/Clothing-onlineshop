package com.shop.swp391.entity;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ShopOrder {
    private int shopOrderID;
    private int userID;
    private int addressID;
    private int orderTotal;
    private int orderStatus;
    private String recipient;
    private String recipientPhone;
}
