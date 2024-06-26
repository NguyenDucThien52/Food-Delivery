package com.datn.food_delivery.dto;

import org.springframework.web.multipart.MultipartFile;

public class CategoryDTO {
    private Long category_id;
    private String name;
    private MultipartFile imageURL;

    public CategoryDTO() {
    }

    public CategoryDTO(Long category_id, String name, MultipartFile imageURL) {
        this.category_id = category_id;
        this.name = name;
        this.imageURL = imageURL;
    }

    public CategoryDTO(Long category_id, String name) {
        this.category_id = category_id;
        this.name = name;
    }

    public Long getCategory_id() {
        return category_id;
    }

    public void setCategory_id(Long category_id) {
        this.category_id = category_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public MultipartFile getImageURL() {
        return imageURL;
    }

    public void setImageURL(MultipartFile imageURL) {
        this.imageURL = imageURL;
    }
}
