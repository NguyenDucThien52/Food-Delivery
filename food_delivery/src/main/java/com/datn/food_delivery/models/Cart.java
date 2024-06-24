package com.datn.food_delivery.models;



import java.util.List;

public class Cart {
    private Long cart_id;
    private String email;

    public Cart(){}

    public Cart(Long cart_id, String email) {
        this.cart_id = cart_id;
        this.email = email;
    }

    public Long getCart_id() {
        return cart_id;
    }

    public void setCart_id(Long cart_id) {
        this.cart_id = cart_id;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
