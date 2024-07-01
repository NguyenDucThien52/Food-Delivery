package com.datn.food_delivery.controllers;

import com.datn.food_delivery.models.FavoriteFood;
import com.datn.food_delivery.service.FavoriteFoodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping(path = "/api/favorite_foods")
public class FavoriteFoodController {
    @Autowired
    private FavoriteFoodService favoriteFoodService;

    @GetMapping("")
    public List<FavoriteFood> getAllFavoriteFoods(@RequestParam String email) throws ExecutionException, InterruptedException {
        return favoriteFoodService.getAllFavoriteFoods(email);
    }

    @GetMapping("/getfavoritefoodbyproduct")
    public FavoriteFood getFavoriteFood(@RequestParam String email, Long product_id) throws ExecutionException, InterruptedException {
        return favoriteFoodService.getFavoriteFood(email, product_id);
    }

    @PostMapping("/insert")
    public void insertFavoriteFood(@RequestBody FavoriteFood favoriteFood) {
        favoriteFoodService.insertFavoriteFood(favoriteFood);
    }

    @GetMapping("/delete")
    public void deleteFavoriteFood(@RequestParam Long favoriteFood_id) throws ExecutionException, InterruptedException {
        favoriteFoodService.deleteFavoriteFood(favoriteFood_id);
    }
}
