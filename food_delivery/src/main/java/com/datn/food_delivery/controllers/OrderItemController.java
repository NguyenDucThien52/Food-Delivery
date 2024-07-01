package com.datn.food_delivery.controllers;


import com.datn.food_delivery.models.OrderItem;
import com.datn.food_delivery.service.OrderItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.concurrent.ExecutionException;

@CrossOrigin(allowedHeaders ="*",methods = {RequestMethod.POST , RequestMethod.GET})
@RestController
@RequestMapping(path = "/api/orderItems")
public class OrderItemController {

    @Autowired
    private OrderItemService orderItemService;

    @GetMapping("")
    List<OrderItem> getOrderItems(@RequestParam Long order_id) throws ExecutionException, InterruptedException {
        return orderItemService.getAllOrderItemsByOrderId(order_id);
    }

    @PostMapping("/insert")
    void insertOrderItem(@RequestBody OrderItem orderItem) {
        orderItemService.saveOrderItem(orderItem);
    }
}
