package com.datn.food_delivery.models;

import jakarta.persistence.*;

@Entity
public class User {
    @Id
    private String email;
    private String fullName;
    private String password;
    private String phoneNumber;
    private String address;
    private String imageURL;
//    @OneToMany
//    private Order order;
//    @OneToMany
//    private Payment payment;
//    @OneToMany
//    private Review review;
//    @OneToOne
//    private FavoriteFood favoriteFood;
//    @OneToOne
//    private FavoriteShop favoriteShop;

    public User() {
    }

    public User(String fullName, String email, String password, String phoneNumber, String address) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.phoneNumber = phoneNumber;
        this.address = address;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
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
