package com.datn.food_delivery.models;

import jakarta.persistence.*;

import java.util.List;

//@Entity
public class Category {
//    @Id
//    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long category_id;
    private String name;
    private String imageURL;


    public Category() {
    }

    public Category(long category_id, String name, String imageURL) {
        this.category_id = category_id;
        this.name = name;
        this.imageURL = imageURL;
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

    public String getImageURL() {
        return imageURL;
    }
    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }
}
