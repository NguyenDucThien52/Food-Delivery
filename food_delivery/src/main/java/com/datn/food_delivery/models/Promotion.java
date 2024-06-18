package com.datn.food_delivery.models;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import java.util.Date;

//@Entity
public class Promotion {
//    @Id
//    @GeneratedValue(strategy = GenerationType.AUTO)
    private long promotion_id;
    private String code;
    private double discount_percentage;
    private Date expiration_date;

    public Promotion() {
    }

    public Promotion(String code, double discount_percentage, Date expiration_date) {
        this.code = code;
        this.discount_percentage = discount_percentage;
        this.expiration_date = expiration_date;
    }

    public long getPromotion_id() {
        return promotion_id;
    }

    public void setPromotion_id(long promotion_id) {
        this.promotion_id = promotion_id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public double getDiscount_percentage() {
        return discount_percentage;
    }

    public void setDiscount_percentage(double discount_percentage) {
        this.discount_percentage = discount_percentage;
    }

    public Date getExpiration_date() {
        return expiration_date;
    }

    public void setExpiration_date(Date expiration_date) {
        this.expiration_date = expiration_date;
    }
}
