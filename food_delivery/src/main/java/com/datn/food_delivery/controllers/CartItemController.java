package com.datn.food_delivery.controllers;

import com.datn.food_delivery.models.CartItem;
import com.datn.food_delivery.service.CartItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.concurrent.ExecutionException;

@CrossOrigin(allowedHeaders ="*",methods = {RequestMethod.POST , RequestMethod.GET})
@RestController
@RequestMapping(path = "/api/cartItems")
public class CartItemController {

    @Autowired
    private CartItemService cartItemService;

    @GetMapping("")
    CartItem getCartItem(@RequestParam Long product_id, Long cart_id) throws ExecutionException, InterruptedException{
        return cartItemService.getCartItem(product_id, cart_id);
    }

    @GetMapping("/getcartitemsbycart")
    List<CartItem> getCartitemsByCart(@RequestParam Long cart_id) throws ExecutionException, InterruptedException{
        return cartItemService.getCartItemByCart(cart_id);
    }

    @PostMapping("/insert")
    void insertCartItem(@RequestBody CartItem cartItem) throws ExecutionException, InterruptedException{
        cartItemService.saveCartItem(cartItem);
    }
}
