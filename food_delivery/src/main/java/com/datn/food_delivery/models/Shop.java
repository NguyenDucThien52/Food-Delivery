package com.datn.food_delivery.models;

public class Shop {
    private Long shop_id;
    private String name;
    private String address;
    private String imageURL;

    public Shop(Long shop_id, String name, String address, String imageURL) {
        this.shop_id = shop_id;
        this.name = name;
        this.address = address;
        this.imageURL = imageURL;
    }

    public Shop(Long shop_id, String name, String address) {
        this.shop_id = shop_id;
        this.name = name;
        this.address = address;
    }

    public Shop() {
    }

    public long getShop_id() {
        return shop_id;
    }

    public void setShop_id(long shop_id) {
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

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }
}
