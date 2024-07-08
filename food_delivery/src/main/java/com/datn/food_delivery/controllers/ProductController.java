package com.datn.food_delivery.controllers;

import com.datn.food_delivery.models.Product;
import com.datn.food_delivery.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.concurrent.ExecutionException;

@CrossOrigin(allowedHeaders ="*",methods = {RequestMethod.POST , RequestMethod.GET})
@RestController
@RequestMapping(path = "/api/products")
public class ProductController {

    @Autowired
    private ProductService firebaseService;

    @GetMapping("")
    List<Product> getAllFoods() throws ExecutionException, InterruptedException {
        return firebaseService.getAllProducts();
    }

    @PostMapping("/insert")
    void insertProduct(@RequestBody Product product) throws ExecutionException, InterruptedException {
        firebaseService.saveProduct(product);
    }

    @GetMapping("/getProductByCart")
    List<Product> getProductsByCartItem(@RequestParam List<Long> product_id) throws  ExecutionException, InterruptedException{
        return firebaseService.getProductsByCartItem(product_id);
    }

    @GetMapping("/getProductbyCategory")
    List<Product> getProductsByCategory(@RequestParam Long category_id) throws  ExecutionException, InterruptedException{
        return firebaseService.getProductsByCategory(category_id);
    }
    @GetMapping("/getProductByid")
    Product getProductById(@RequestParam Long product_id) throws  ExecutionException, InterruptedException{
        return firebaseService.getProductByid(product_id);
    }

    @GetMapping("/getProductbyKeyWord")
    List<Product> getProductsByKeyWord(@RequestParam String keyword) throws  ExecutionException, InterruptedException{
        return firebaseService.getProductsByKeyword(keyword);
    }
}


