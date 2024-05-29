package com.datn.food_delivery.models;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class FavoriteFood {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long favoriteFood_id;
    private int food_id;

    public FavoriteFood(int food_id) {
        this.food_id = food_id;
    }

    public long getFavoriteFood_id() {
        return favoriteFood_id;
    }

    public void setFavoriteFood_id(long favoriteFood_id) {
        this.favoriteFood_id = favoriteFood_id;
    }

    public int getFood_id() {
        return food_id;
    }

    public void setFood_id(int food_id) {
        this.food_id = food_id;
    }
}
