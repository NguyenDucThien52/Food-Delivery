package com.datn.food_delivery.controllers;

import com.datn.food_delivery.models.Category;
import com.datn.food_delivery.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping(path = "/api/categories")
public class CategoryController {
    @Autowired
    CategoryService categoryService;

    @GetMapping("")
    public List<Category> getAllCategories() throws ExecutionException, InterruptedException {
        return categoryService.getAllCategory();
    }
}
