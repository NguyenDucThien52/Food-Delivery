package com.datn.food_delivery.models;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class FavoriteShop {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long favorite_id;
    private long shop_id;

    public FavoriteShop(long shop_id) {
        this.shop_id = shop_id;
    }

    public long getFavorite_id() {
        return favorite_id;
    }

    public void setFavorite_id(long favorite_id) {
        this.favorite_id = favorite_id;
    }

    public long getShop_id() {
        return shop_id;
    }

    public void setShop_id(long shop_id) {
        this.shop_id = shop_id;
    }
}
