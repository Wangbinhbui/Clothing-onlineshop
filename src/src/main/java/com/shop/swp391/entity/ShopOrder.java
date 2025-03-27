package com.shop.swp391.entity;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ShopOrder {
    private Integer shopOrderID;
    private Integer userID;
    private Integer addressID;
    private Integer orderTotal;
    private Integer orderStatus;
    private String recipient;
    private String recipientPhone;
}
