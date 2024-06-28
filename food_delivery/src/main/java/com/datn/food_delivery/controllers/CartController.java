package com.datn.food_delivery.controllers;

import com.datn.food_delivery.models.Cart;
import com.datn.food_delivery.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.ExecutionException;

@CrossOrigin(allowedHeaders ="*",methods = {RequestMethod.POST , RequestMethod.GET})
@RestController
@RequestMapping(path = "/api/carts")
public class CartController {

    @Autowired
    private CartService cartService;

    @GetMapping("")
    Cart getCart(@RequestParam String email) throws ExecutionException, InterruptedException {
        return cartService.getCart(email);
    }


    @PostMapping("/insert")
    void insertCart(@RequestBody Cart cart) throws ExecutionException, InterruptedException{
        cartService.saveCart(cart);
    }
}
