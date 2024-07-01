package com.datn.food_delivery.models;

public class FavoriteShop {
    private Long favoriteShop_id;
    private Long shop_id;
    private String email;

    public FavoriteShop() {
    }

    public FavoriteShop(Long favoriteShop_id, Long shop_id, String email) {
        this.favoriteShop_id = favoriteShop_id;
        this.shop_id = shop_id;
        this.email = email;
    }

    public long getFavoriteShop_id() {
        return favoriteShop_id;
    }

    public void setFavoriteShop_id(long favoriteShop_id) {
        this.favoriteShop_id = favoriteShop_id;
    }

    public Long getShop_id() {
        return shop_id;
    }

    public void setShop_id(Long shop_id) {
        this.shop_id = shop_id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
