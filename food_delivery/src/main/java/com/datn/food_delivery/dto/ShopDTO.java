package com.datn.food_delivery.dto;

import org.springframework.web.multipart.MultipartFile;

public class ShopDTO {
    private Long shop_id;
    private String name;
    private String address;
    private MultipartFile imageURL;

    public ShopDTO() {
    }

    public ShopDTO(Long shop_id, String name, String address, MultipartFile imageURL) {
        this.shop_id = shop_id;
        this.name = name;
        this.address = address;
        this.imageURL = imageURL;
    }

    public ShopDTO(Long shop_id, String name, String address) {
        this.shop_id = shop_id;
        this.name = name;
        this.address = address;
    }

    public Long getShop_id() {
        return shop_id;
    }

    public void setShop_id(Long shop_id) {
        this.shop_id = shop_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public MultipartFile getImageURL() {
        return imageURL;
    }

    public void setImageURL(MultipartFile imageURL) {
        this.imageURL = imageURL;
    }
}
