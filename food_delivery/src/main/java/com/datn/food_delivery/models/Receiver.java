package com.datn.food_delivery.models;

public class Receiver {
    private Long receiver_id;
    private String receiver_name;
    private String receiver_phone;

    public Receiver(Long receiver_id, String receiver_name, String receiver_phone) {
        this.receiver_id = receiver_id;
        this.receiver_name = receiver_name;
        this.receiver_phone = receiver_phone;
    }

    public Long getReceiver_id() {
        return receiver_id;
    }

    public void setReceiver_id(Long receiver_id) {
        this.receiver_id = receiver_id;
    }

    public String getReceiver_name() {
        return receiver_name;
    }

    public void setReceiver_name(String receiver_name) {
        this.receiver_name = receiver_name;
    }


    public String getReceiver_phone() {
        return receiver_phone;
    }

    public void setReceiver_phone(String receiver_phone) {
        this.receiver_phone = receiver_phone;
    }
}
