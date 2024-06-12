package com.datn.food_delivery.controllers;
import com.datn.food_delivery.models.User;
import com.datn.food_delivery.service.FirebaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private FirebaseService firebaseService;

    @PostMapping("/save")
    public void saveUser(@RequestBody User user) throws ExecutionException, InterruptedException {
        firebaseService.saveUser(user);
    }
}
