package com.datn.food_delivery.models;

import jakarta.persistence.*;

import java.util.List;

//@Entity
public class Category {
//    @Id
//    @GeneratedValue(strategy = GenerationType.AUTO)
    private long category_id;
    private String name;


    public Category() {
    }

    public Category(String name) {
        this.name = name;
    }

    public long getCategory_id() {
        return category_id;
    }

    public void setCategory_id(long category_id) {
        this.category_id = category_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
