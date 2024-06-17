package com.datn.food_delivery.models;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "Carts")
public class Cart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long cart_id;
    private String email;
    private List<Long> product_id;

    public Cart(){}

    public Cart(Long cart_id, String email, List<Long> product_id) {
        this.cart_id = cart_id;
        this.email = email;
        this.product_id = product_id;
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

    public List<Long> getProduct_id() {
        return product_id;
    }

    public void setProduct_id(List<Long> product_id) {
        this.product_id = product_id;
    }
}
