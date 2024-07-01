package com.datn.food_delivery.models;

public class FavoriteFood {
    private Long favoriteFood_id;
    private Long product_id;
    private String email;

    public FavoriteFood() {
    }

    public FavoriteFood(Long favoriteFood_id, Long product_id, String email) {
        this.favoriteFood_id = favoriteFood_id;
        this.product_id = product_id;
        this.email = email;
    }

    public FavoriteFood(Long product_id) {
        this.product_id = product_id;
    }

    public long getFavoriteFood_id() {
        return favoriteFood_id;
    }

    public void setFavoriteFood_id(long favoriteFood_id) {
        this.favoriteFood_id = favoriteFood_id;
    }

    public Long getProduct_id() {
        return product_id;
    }

    public void setProduct_id(Long product_id) {
        this.product_id = product_id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
