package com.shop.swp391.entity;

import lombok.*;

@ToString
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class CartItem {
    private int cartItemId;
    private int cartId;
    private int productId;
    private int quantity;
    private int variationId;
    private Product product;
}
