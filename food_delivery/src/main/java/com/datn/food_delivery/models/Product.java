package com.datn.food_delivery.models;

import jakarta.persistence.*;

//@Entity
//@Table(name = "Product")
public class Product {
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long product_id;
    private String name;
    private String description;
    private double price;
    private Long category_id;
    private String imageURL;


    public Product() {
    }

    public Product(Long product_id, String name, String description, double price, Long category_id, String imageURL) {
        this.product_id = product_id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.category_id = category_id;
        this.imageURL = imageURL;
    }

    public Product(Long product_id, String name, String description, double price, Long category_id) {
        this.product_id = product_id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.category_id = category_id;
    }

    public long getProduct_id() {
        return product_id;
    }

    public void setProduct_id(long product_id) {
        this.product_id = product_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Long getCategory_id() {
        return category_id;
    }

    public void setCategory_id(Long category_id) {
        this.category_id = category_id;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }


}
