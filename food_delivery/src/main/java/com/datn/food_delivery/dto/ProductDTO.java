package com.datn.food_delivery.dto;

import org.springframework.web.multipart.MultipartFile;

public class ProductDTO {
    private Long productId;
    private String name;
    private String description;
    private double price;
    private Long categoryId;
    private MultipartFile imageURL;

    public ProductDTO(Long productId, String name, String description, double price, Long categoryId) {
        this.productId = productId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.categoryId = categoryId;
    }

    // Getter và Setter cho các thuộc tính
    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
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

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    public MultipartFile getImageURL() {
        return imageURL;
    }

    public void setImageURL(MultipartFile imageURL) {
        this.imageURL = imageURL;
    }
}
