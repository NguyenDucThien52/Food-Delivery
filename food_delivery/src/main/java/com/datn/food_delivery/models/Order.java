package com.datn.food_delivery.models;

import jakarta.persistence.*;
import org.springframework.boot.autoconfigure.web.WebProperties;

import java.util.Date;
import java.util.List;

//@Entity
//@Table(name = "Orders")
public class Order {
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long order_id;
    private double totalAmount;
    private Date orderDate;
    private String deliveryAddress;
    private String paymentMethod;
    private String email;

    public Order() {
    }

    public Order(double totalAmount, Date orderDate, String deliveryAddress, String email) {
        this.totalAmount = totalAmount;
        this.orderDate = orderDate;
        this.deliveryAddress = deliveryAddress;
        this.email = email;
    }

    public void setOrder_id(Long order_id) {
        this.order_id = order_id;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

}
