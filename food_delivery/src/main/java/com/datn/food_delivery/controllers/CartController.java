package com.datn.food_delivery.controllers;

import com.datn.food_delivery.models.Cart;
import com.datn.food_delivery.service.FirebaseService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@CrossOrigin(allowedHeaders ="*",methods = {RequestMethod.POST , RequestMethod.GET})
@RestController
@RequestMapping(path = "/api/carts")
public class CartController {

    @Autowired
    private FirebaseService firebaseService;

    @GetMapping("")
    Cart getCart(@RequestParam String email) throws ExecutionException, InterruptedException {
        return firebaseService.getCart(email);
    }


    @PostMapping("/insert")
    void insertCart(@RequestBody Cart cart) throws ExecutionException, InterruptedException{
        firebaseService.saveCart(cart);
    }
}
