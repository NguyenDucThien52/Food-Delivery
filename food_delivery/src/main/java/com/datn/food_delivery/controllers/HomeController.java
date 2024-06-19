package com.datn.food_delivery.controllers;

import com.datn.food_delivery.mapper.ProductMapper;
import com.datn.food_delivery.models.Product;
import com.datn.food_delivery.dto.ProductDTO;
import com.datn.food_delivery.service.FirebaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;
import java.util.Random;
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
    public String addProduct(){
        return "/products/create";
    }

    @PostMapping ("/store")
    public String saveProduct(ProductDTO productDTO) throws ExecutionException, InterruptedException, IOException {
//        System.out.println(productDTO.getProduct_id());
        final Long id = new Random().nextLong(100000);
        productDTO.setProductId(id);
        String imageURL = service.uploadFile(productDTO.getImageURL());
        Product product = new Product(productDTO.getProductId(), productDTO.getName(), productDTO.getDescription(), productDTO.getPrice(), imageURL);
        service.saveProduct(product);
        return "redirect:/products";
    }

    @GetMapping("/edit/{id}")
    public String editProduct(@PathVariable("id") long id, Model model) throws ExecutionException, InterruptedException {
        Product product = service.getProductByid(id);
        model.addAttribute("product", product);
        return "products/edit";
    }

    @PostMapping("/edit/update")
    public String updateProduct(Product product) throws ExecutionException, InterruptedException {
        service.saveProduct(product);
        return "redirect:/products";
    }

    @GetMapping("/destroy/{id}")
    public String deleteProduct(@PathVariable("id") Long id) throws ExecutionException, InterruptedException {
        service.deleteProduct(id);
        return "redirect:/products";
    }
}
