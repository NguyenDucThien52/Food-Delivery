package com.datn.food_delivery.controllers;

import com.datn.food_delivery.models.Shop;
import com.datn.food_delivery.service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping(path = "/api/shops")
public class ShopController {
    @Autowired
    private ShopService shopService;

    @GetMapping("")
    public List<Shop> getAllShops() throws ExecutionException, InterruptedException {
        return shopService.getAllShops();
    }
}
