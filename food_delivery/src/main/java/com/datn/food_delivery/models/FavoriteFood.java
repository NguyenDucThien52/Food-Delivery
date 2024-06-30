package com.datn.food_delivery.models;

public class FavoriteFood {
    private Long favoriteFood_id;
    private int product_id;
    private Long user_id;

    public FavoriteFood() {
    }

    public FavoriteFood(Long favoriteFood_id, int food_id, Long user_id) {
        this.favoriteFood_id = favoriteFood_id;
        this.product_id = food_id;
        this.user_id = user_id;
    }

    public FavoriteFood(int food_id) {
        this.product_id = food_id;
    }

    public long getFavoriteFood_id() {
        return favoriteFood_id;
    }

    public void setFavoriteFood_id(long favoriteFood_id) {
        this.favoriteFood_id = favoriteFood_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public Long getUser_id() {
        return user_id;
    }

    public void setUser_id(Long user_id) {
        this.user_id = user_id;
    }
}
