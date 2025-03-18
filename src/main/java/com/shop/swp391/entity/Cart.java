package com.shop.swp391.entity;

import lombok.*;

@ToString
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Cart {
    private int cartId;
    private int userId;
}
