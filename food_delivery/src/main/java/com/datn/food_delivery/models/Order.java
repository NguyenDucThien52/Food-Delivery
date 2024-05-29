package com.datn.food_delivery.models;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import org.springframework.boot.autoconfigure.web.WebProperties;

import java.util.Date;

@Entity
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long order_id;
    private double totalAmount;
    private Date orderDate;
    private String deliveryAddress;
    private long user_id;
    private long promotion_id;

    public Order() {
    }

    public Order(double totalAmount, Date orderDate, String deliveryAddress) {
        this.totalAmount = totalAmount;
        this.orderDate = orderDate;
        this.deliveryAddress = deliveryAddress;
    }

    public Order(double totalAmount, Date orderDate, String deliveryAddress, long user_id) {
        this.totalAmount = totalAmount;
        this.orderDate = orderDate;
        this.deliveryAddress = deliveryAddress;
        this.user_id = user_id;
    }

    public long getOrder_id() {
        return order_id;
    }

    public void setOrder_id(long order_id) {
        this.order_id = order_id;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public long getUser_id() {
        return user_id;
    }

    public void setUser_id(long user_id) {
        this.user_id = user_id;
    }

    public long getPromotion_id() {
        return promotion_id;
    }

    public void setPromotion_id(long promotion_id) {
        this.promotion_id = promotion_id;
    }
}
