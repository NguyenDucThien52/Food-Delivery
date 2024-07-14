package com.datn.food_delivery.models;

import org.springframework.boot.autoconfigure.web.WebProperties;

import java.util.Date;
import java.util.List;

public class Order {
    private Long order_id;
    private double totalAmount;
    private double quantity;
    private Date orderDate;
    private String deliveryAddress;
    private String paymentMethod;
    private String email;
    private Long receiver_id;
    private String Order_Status;

    public Order() {
    }

    public Order(Long order_id, double totalAmount, int quantity, Date orderDate, String deliveryAddress, String paymentMethod, String email, Long receiver_id, String Order_Status) {
        this.order_id = order_id;
        this.totalAmount = totalAmount;
        this.quantity = quantity;
        this.orderDate = orderDate;
        this.deliveryAddress = deliveryAddress;
        this.paymentMethod = paymentMethod;
        this.email = email;
        this.receiver_id = receiver_id;
        this.Order_Status = Order_Status;
    }


    public Long getReceiver_id() {
        return receiver_id;
    }

    public void setReceiver_id(Long receiver_id) {
        this.receiver_id = receiver_id;
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

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
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

    public String getOrder_Status() {
        return Order_Status;
    }

    public void setOrder_Status(String order_Status) {
        Order_Status = order_Status;
    }
}
