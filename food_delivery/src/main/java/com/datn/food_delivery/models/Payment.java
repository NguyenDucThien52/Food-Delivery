package com.datn.food_delivery.models;

import jakarta.persistence.*;

import java.util.Date;

@Entity
public class Payment {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long payment_id;
    private String paymentMethod;
    private Date paymentDate;
//    @ManyToOne
//    @JoinColumn(name = "user_id")
//    private User user;

    public Payment() {
    }

    public Payment(String paymentMethod, Date paymentDate) {
        this.paymentMethod = paymentMethod;
        this.paymentDate = paymentDate;
    }



    public long getPayment_id() {
        return payment_id;
    }

    public void setPayment_id(long payment_id) {
        this.payment_id = payment_id;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }
}
