package com.datn.food_delivery.controllers;

import com.datn.food_delivery.models.Receiver;
import com.datn.food_delivery.service.ReceiverService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(allowedHeaders ="*",methods = {RequestMethod.POST , RequestMethod.GET})
@RestController
@RequestMapping(path = "/api/receiver")
public class RecieverController {

    @Autowired
    private ReceiverService receiverService;

    @PostMapping("/insert")
    public void insertReceiver(@RequestBody Receiver receiver) {
        receiverService.saveReceiver(receiver);
    }
}
