package com.datn.food_delivery.controllers;

import com.datn.food_delivery.models.Order;
import com.datn.food_delivery.service.OrderService;
import com.datn.food_delivery.service.SendEmailService;
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

    @Autowired
    private SendEmailService sendEmailService;

    @GetMapping("")
    public List<Order> getAllOrdersbyEmail(@RequestParam String email) throws ExecutionException, InterruptedException {
        return orderService.getAllOrderbyEmail(email);
    }

    @GetMapping("/getall")
    public List<Order> getAllOrder() throws ExecutionException, InterruptedException {
        return orderService.getAllOrder();
    }

    @GetMapping("/sendemail")
    public String sendemail(){
        return "Sent successfully";
    }

    @PostMapping("/insert")
    public void insertOrder(@RequestBody Order order){
        String subject = "Order " + order.getOrder_id();
        String body = "email: " + order.getEmail() + "\n"+ "Số lượng: " + order.getTotalAmount() + "\n" + "Thời gian: " +order.getOrderDate();
        sendEmailService.sendEmail("thien14112002@gmail.com",subject,body);
        orderService.saveOrder(order);
    }
}
