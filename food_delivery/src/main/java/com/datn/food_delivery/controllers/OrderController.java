package com.datn.food_delivery.controllers;

import com.datn.food_delivery.models.Order;
import com.datn.food_delivery.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.concurrent.ExecutionException;

@CrossOrigin(allowedHeaders ="*",methods = {RequestMethod.POST , RequestMethod.GET})
@RestController
@RequestMapping(path = "/api/orders")
public class OrderController {
    @Autowired
    private OrderService orderService;

    @GetMapping("")
    public List<Order> getAllOrders(@RequestParam String email) throws ExecutionException, InterruptedException {
        return orderService.getAllOrder(email);
    }

    @PostMapping("/insert")
    public void insertOrder(@RequestBody Order order){
        orderService.saveOrder(order);
    }
}
