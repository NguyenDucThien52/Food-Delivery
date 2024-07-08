package com.datn.food_delivery.controllers;

import com.datn.food_delivery.models.FavoriteShop;
import com.datn.food_delivery.service.FavoriteShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping(path ="/api/favorite_shops")
public class FavoriteShopController {
    @Autowired
    private FavoriteShopService favoriteShopService;

    @GetMapping("")
    public FavoriteShop getFavoriteShop(@RequestParam Long shop_id, String email) throws ExecutionException, InterruptedException {
        return favoriteShopService.favoriteShop(shop_id, email);
    }

    @PostMapping("/insert")
    public void insertFavoriteShop(@RequestBody FavoriteShop favoriteShop) {
        favoriteShopService.saveFavoriteShop(favoriteShop);
    }

    @GetMapping("/delete")
    public void deleteFavoriteShop(@RequestParam Long favoriteShop_id) throws ExecutionException, InterruptedException {
        favoriteShopService.deleteFavoriteShop(favoriteShop_id);
    }

}
