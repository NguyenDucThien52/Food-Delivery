package com.datn.food_delivery.controllers;

import com.datn.food_delivery.models.Product;
import com.datn.food_delivery.repositories.ProductRepository;
import com.datn.food_delivery.service.FirebaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.concurrent.ExecutionException;

@Controller
@RequestMapping("/products")
public class HomeController {
    @Autowired
    private FirebaseService service;


    @GetMapping("")
    public  String showProductlist(Model model) throws ExecutionException, InterruptedException {
        List<Product> products = service.getAllProducts();
        model.addAttribute("products", products);
        return "products/index";
    }

    @GetMapping("/create")
    public String addProduct() throws ExecutionException, InterruptedException {
        List<Product> products = service.getAllProducts();
        return "/products/create";
    }

    @PostMapping ("/store")
    public String saveProduct(Product product) throws ExecutionException, InterruptedException {
        service.saveProdct(product);
        return "redirect:/products";
    }

//    @GetMapping("/edit/{id}")
//    public String editProduct(@PathVariable("id") long id, Model model){
//        Product product = service.findById(id).orElseThrow(()-> new IllegalArgumentException("Invalid product id: " + id));
//        model.addAttribute("product", product);
//        return "products/edit";
//    }
//
//    @PostMapping("/edit/update")
//    public String updateProduct(Product product){
//        repository.save(product);
//        return "redirect:/products";
//    }
//
//    @GetMapping("/destroy/{id}")
//    public String deleteProduct(@PathVariable("id") Long id){
//        Product product = repository.findById(id).orElseThrow(()->new IllegalArgumentException("Invalid product id: " + id));
//        repository.delete(product);
//        return "redirect:/products";
//    }
}
