package com.datn.food_delivery.models;

import jakarta.persistence.*;
import org.aspectj.weaver.ast.Or;

//@Entity
public class OrderItem {
    //    @Id
//    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long orderItem_id;
    private int quantity;
    private Long prouct_id;

//    @ManyToOne
//    @JoinColumn(name = "product_id")
//    private Product product;
//
//    @ManyToOne
//    @JoinColumn(name = "order_id")
//    private Order order;

    public OrderItem() {
    }

    public OrderItem(Long orderItem_id, int quantity, Long prouct_id) {
        this.orderItem_id = orderItem_id;
        this.quantity = quantity;
        this.prouct_id = prouct_id;
    }

    public void setOrderItem_id(Long orderItem_id) {
        this.orderItem_id = orderItem_id;
    }

    public Long getProuct_id() {
        return prouct_id;
    }

    public void setProuct_id(Long prouct_id) {
        this.prouct_id = prouct_id;
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
