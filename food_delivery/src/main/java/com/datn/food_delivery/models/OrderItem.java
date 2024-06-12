package com.datn.food_delivery.models;

import jakarta.persistence.*;
import org.aspectj.weaver.ast.Or;

@Entity
public class OrderItem {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long orderItem_id;
    private int quantity;

//    @ManyToOne
//    @JoinColumn(name = "product_id")
//    private Product product;
//
//    @ManyToOne
//    @JoinColumn(name = "order_id")
//    private Order order;

    public OrderItem() {
    }

    public OrderItem(int quantity, long food_id, long order_id) {
        this.quantity = quantity;
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
}
