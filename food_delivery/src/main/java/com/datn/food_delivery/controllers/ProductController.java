package com.datn.food_delivery.controllers;

import com.datn.food_delivery.models.Product;
import com.datn.food_delivery.service.FirebaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.concurrent.ExecutionException;

@CrossOrigin(allowedHeaders ="*",methods = {RequestMethod.POST , RequestMethod.GET})
@RestController
@RequestMapping(path = "/api/products")
public class ProductController {

    @Autowired
    private FirebaseService firebaseService;

    @GetMapping("")
    List<Product> getAllFoods() throws ExecutionException, InterruptedException {
        return firebaseService.getAllProducts();
    }

    @PostMapping("/insert")
    void insertProduct(@RequestBody Product product) throws ExecutionException, InterruptedException {
        firebaseService.saveProduct(product);
    }

    @GetMapping("/getProductByCart")
    List<Product> getProductsByCart(@RequestParam List<Long> product_id) throws  ExecutionException, InterruptedException{
        return firebaseService.getProductsByCart(product_id);
    }

//    @GetMapping("/{id}")
//    ResponseEntity<ResponseObject> findById(@PathVariable Long id){
//        Optional<Product> product = repository.findById(id);
//        return product.isEmpty() ?
//                ResponseEntity.status(HttpStatus.NOT_FOUND).body(new ResponseObject("404", "Can't not find product with id = " + id, ""))
//                : ResponseEntity.status(HttpStatus.OK).body(new ResponseObject("200", "Query product successfully", product));
//
//    }

//
//    @DeleteMapping("/delete/{id}")
//    ResponseEntity<ResponseObject> deleteProduct(@RequestBody Product product){
//        Long id = product.getProduct_id();
//        return ResponseEntity.status(HttpStatus.OK).body(new ResponseObject("200", "Delete product " + product.getProduct_id() + " successfully", product));
//    }
}


