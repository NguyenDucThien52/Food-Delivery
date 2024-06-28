package com.datn.food_delivery.controllers;
import com.datn.food_delivery.models.User;
import com.datn.food_delivery.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("api/users")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("")
    public User getCurrentUser(@RequestParam String email) throws ExecutionException, InterruptedException {
        return userService.getUser(email);
    }

    @PostMapping("/insert")
    public void saveUser(@RequestBody User user) throws ExecutionException, InterruptedException {
        userService.saveUser(user);
    }
}
