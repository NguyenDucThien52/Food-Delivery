package com.datn.food_delivery.controllers;

import com.datn.food_delivery.models.Product;
import com.datn.food_delivery.models.ResponseObject;
import com.datn.food_delivery.repositories.ProductRepository;
import com.datn.food_delivery.service.FirebaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;

@CrossOrigin(allowedHeaders ="*",methods = {RequestMethod.POST , RequestMethod.GET})
@RestController
@RequestMapping(path = "/api/products")
public class FoodController {

    @Autowired
    private FirebaseService firebaseService;

    @GetMapping("")
    List<Product> getAllFoods() throws ExecutionException, InterruptedException {
        return firebaseService.getAllProducts();
    }

//    @GetMapping("/{id}")
//    ResponseEntity<ResponseObject> findById(@PathVariable Long id){
//        Optional<Product> product = repository.findById(id);
//        return product.isEmpty() ?
//                ResponseEntity.status(HttpStatus.NOT_FOUND).body(new ResponseObject("404", "Can't not find product with id = " + id, ""))
//                : ResponseEntity.status(HttpStatus.OK).body(new ResponseObject("200", "Query product successfully", product));
//
//    }

//    @PostMapping("/insert")
//    ResponseEntity<ResponseObject> insertProduct(@RequestBody Product product){
//        System.out.println(product);
//        return ResponseEntity.status(HttpStatus.OK).body(new ResponseObject("200", "Insert product successfullly", repository.save(product)));
//    }
//
//    @DeleteMapping("/delete/{id}")
//    ResponseEntity<ResponseObject> deleteProduct(@RequestBody Product product){
//        Long id = product.getProduct_id();
//        return ResponseEntity.status(HttpStatus.OK).body(new ResponseObject("200", "Delete product " + product.getProduct_id() + " successfully", product));
//    }
}


