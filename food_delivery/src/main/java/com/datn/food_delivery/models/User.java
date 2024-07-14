package com.datn.food_delivery.models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private String email;
    private String fullName;
    private String password;
    private String phoneNumber;
    private String address;
    private String imageURL;
    private String roles;

}
