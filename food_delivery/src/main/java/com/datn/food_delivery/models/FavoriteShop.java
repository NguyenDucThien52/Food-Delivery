package com.datn.food_delivery.models;

import jakarta.persistence.*;

//@Entity
public class FavoriteShop {
//    @Id
//    @GeneratedValue(strategy = GenerationType.AUTO)
    private long favorite_id;
//    @ManyToOne
//    @JoinColumn(name = "shop_id")
//    private Shop shop;

    public FavoriteShop() {
    }

    public long getFavorite_id() {
        return favorite_id;
    }

    public void setFavorite_id(long favorite_id) {
        this.favorite_id = favorite_id;
    }

}
