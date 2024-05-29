package com.datn.food_delivery.models;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class OrderItem {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long orderItem_id;
    private int quantity;
    private long food_id;
    private long order_id;

    public OrderItem() {
    }

    public OrderItem(int quantity, long food_id, long order_id) {
        this.quantity = quantity;
        this.food_id = food_id;
        this.order_id = order_id;
    }

    public long getOrderItem_id() {
        return orderItem_id;
    }

    public void setOrderItem_id(long orderItem_id) {
        this.orderItem_id = orderItem_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public long getFood_id() {
        return food_id;
    }

    public void setFood_id(long food_id) {
        this.food_id = food_id;
    }

    public long getOrder_id() {
        return order_id;
    }

    public void setOrder_id(long order_id) {
        this.order_id = order_id;
    }
}
