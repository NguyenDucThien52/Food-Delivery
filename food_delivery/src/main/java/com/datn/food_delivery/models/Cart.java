package com.datn.food_delivery.models;



import java.util.List;

public class Cart {
    private Long cart_id;
    private String email;
    private List<Long> cartItem_id;

    public Cart(){}

    public Cart(Long cart_id, String email, List<Long> product_id) {
        this.cart_id = cart_id;
        this.email = email;
        this.cartItem_id = product_id;
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

    public List<Long> getCartItem_id() {
        return cartItem_id;
    }

    public void setCartItem_id(List<Long> cartItem_id) {
        this.cartItem_id = cartItem_id;
    }
}
