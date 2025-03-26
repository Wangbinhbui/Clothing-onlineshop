package com.shop.swp391.entity;

import lombok.*;
import java.sql.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderDetails {
    private Integer orderDetailID;
    private Integer productID;
    private Integer orderID;
    private Integer quantity;
    private Integer price;
    private Date orderDate;
    private Integer variationID;
}
