package com.datn.food_delivery.controllers;

import com.datn.food_delivery.models.Category;
import com.datn.food_delivery.models.Product;
import com.datn.food_delivery.dto.ProductDTO;
import com.datn.food_delivery.service.CategoryService;
import com.datn.food_delivery.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ExecutionException;

@Controller
@RequestMapping("/fooddelivery/products")
public class ProdutctPageController {
    @Autowired
    private ProductService service;
    @Autowired
    private CategoryService categoryService;


    @GetMapping("")
    public  String showProductlist(Model model) throws ExecutionException, InterruptedException {
        List<Product> products = service.getAllProducts();
        model.addAttribute("products", products);
        return "products/index";
    }

    @GetMapping("/create")
    public String addProduct(Model model) throws ExecutionException, InterruptedException {
        List<Category> categories = categoryService.getAllCategory();
        model.addAttribute("categories", categories);
        return "/products/create";
    }

    @PostMapping ("/store")
    public String saveProduct(ProductDTO productDTO) throws ExecutionException, InterruptedException, IOException {
        final Long id = new Random().nextLong(100000);
        productDTO.setProductId(id);
        String imageURL = null;
        if(!productDTO.getImageURL().isEmpty()) {
            imageURL = service.uploadFile(productDTO.getImageURL());
        }
        Product product = new Product(productDTO.getProductId(), productDTO.getName(), productDTO.getDescription(), productDTO.getPrice(), productDTO.getCategoryId(), imageURL);
        service.saveProduct(product);
        return "redirect:/fooddelivery/products";
    }

    @GetMapping("/edit/{id}")
    public String editProduct(@PathVariable("id") long id, Model model) throws ExecutionException, InterruptedException {
        Product product = service.getProductByid(id);
        ProductDTO productDTO = new ProductDTO(product.getProduct_id(), product.getName(), product.getDescription(), product.getPrice(), product.getCategory_id());
        model.addAttribute("productDTO", productDTO);
        return "products/edit";
    }

    @PostMapping("/edit/update")
    public String updateProduct(ProductDTO productDTO) throws ExecutionException, InterruptedException, IOException {
        Product product_old = service.getProductByid(productDTO.getProductId());
        String imageURL = product_old.getImageURL();
        String newImageURL = service.uploadFile(productDTO.getImageURL());
        if(newImageURL!=null){
            imageURL = newImageURL;
        }
        Product product = new Product(productDTO.getProductId(), productDTO.getName(), productDTO.getDescription(), productDTO.getPrice(), productDTO.getCategoryId(),  imageURL);
        service.saveProduct(product);
        return "redirect:/fooddelivery/products";
    }

    @GetMapping("/destroy/{id}")
    public String deleteProduct(@PathVariable("id") Long id) throws ExecutionException, InterruptedException {
        service.deleteProduct(id);
        return "redirect:/fooddelivery/products";
    }
}
