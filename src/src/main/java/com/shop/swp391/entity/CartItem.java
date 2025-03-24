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
    private Integer cartItemId;
    private Integer cartId;
    private Integer productId;
    private Integer quantity;
    private Integer variationId;
}
