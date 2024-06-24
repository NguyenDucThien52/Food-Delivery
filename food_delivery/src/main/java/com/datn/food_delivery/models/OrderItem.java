package com.datn.food_delivery.models;

public class OrderItem {
    private Long orderItem_id;
    private int quantity;
    private Long product_id;
    private Long order_id;

    public OrderItem() {
    }

    public OrderItem(Long orderItem_id, int quantity, Long product_id, Long order_id) {
        this.orderItem_id = orderItem_id;
        this.quantity = quantity;
        this.product_id = product_id;
        this.order_id = order_id;
    }

    public Long getProduct_id() {
        return product_id;
    }

    public void setProduct_id(Long product_id) {
        this.product_id = product_id;
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

    public Long getOrder_id() {
        return order_id;
    }

    public void setOrder_id(Long order_id) {
        this.order_id = order_id;
    }
}
