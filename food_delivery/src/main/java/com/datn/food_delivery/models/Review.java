package com.datn.food_delivery.models;

public class Review {
    private Long review_id;
    private int rating;
    private String email;
    private Long product_id;

    public Review() {
    }

    public Review(Long review_id, int rating, String email, Long product_id) {
        this.review_id = review_id;
        this.rating = rating;
        this.email = email;
        this.product_id = product_id;
    }

    public Long getReview_id() {
        return review_id;
    }

    public void setReview_id(Long review_id) {
        this.review_id = review_id;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Long getProduct_id() {
        return product_id;
    }

    public void setProduct_id(Long product_id) {
        this.product_id = product_id;
    }
}
