package com.datn.food_delivery.models;

public class CartItem {
    private Long CartItem_id;
    private int quantity;
    private Long product_id;
    private Long cart_id;

    public CartItem() {
    }

    public CartItem(Long cartItem_id, int quantity, Long product_id, Long cart_id) {
        CartItem_id = cartItem_id;
        this.quantity = quantity;
        this.product_id = product_id;
        this.cart_id = cart_id;
    }

    public Long getCartItem_id() {
        return CartItem_id;
    }

    public void setCartItem_id(Long cartItem_id) {
        CartItem_id = cartItem_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Long getProduct_id() {
        return product_id;
    }

    public void setProduct_id(Long product_id) {
        this.product_id = product_id;
    }

    public Long getCart_id() {
        return cart_id;
    }

    public void setCart_id(Long cart_id) {
        this.cart_id = cart_id;
    }
}
