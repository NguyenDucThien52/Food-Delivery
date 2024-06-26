package com.datn.food_delivery.controllers;

import com.datn.food_delivery.dto.CategoryDTO;
import com.datn.food_delivery.dto.ProductDTO;
import com.datn.food_delivery.models.Category;
import com.datn.food_delivery.models.Product;
import com.datn.food_delivery.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ExecutionException;

@Controller
@RequestMapping("/fooddelivery/category")
public class CategoryPageController {
    @Autowired
    private CategoryService categoryService;

    @GetMapping("")
    public String categoryPage(Model model) throws ExecutionException, InterruptedException {
        List<Category> categories = categoryService.getAllCategory();
        model.addAttribute("categories", categories);
        return "category/index";
    }

    @GetMapping("/create")
    public String createCategory(Model model) {
        return "category/create";
    }

    @PostMapping("/store")
    public String storeCategory(CategoryDTO categoryDTO, Model model) throws IOException {
        final Long id = new Random().nextLong(1000000);
        categoryDTO.setCategory_id(id);
        String imageURL = null;
        if (!categoryDTO.getImageURL().isEmpty()) {
            imageURL = categoryService.uploadFile(categoryDTO.getImageURL());
        }
        Category category = new Category(categoryDTO.getCategory_id(), categoryDTO.getName(), imageURL);
        categoryService.saveCategory(category);
        return "redirect:/fooddelivery/category";
    }

    @GetMapping("/edit/{id}")
    public String editProduct(@PathVariable("id") long id, Model model) throws ExecutionException, InterruptedException {
        Category category = categoryService.getCategoryById(id);
        CategoryDTO categoryDTO = new CategoryDTO(category.getCategory_id(), category.getName());
        model.addAttribute("categoryDTO", categoryDTO);
        model.addAttribute("category", category);
        return "category/edit";
    }

    @PostMapping("/edit/update")
    public String updateCategory(CategoryDTO categoryDTO) throws IOException, ExecutionException, InterruptedException {
        Category category_old = categoryService.getCategoryById(categoryDTO.getCategory_id());
        String imageURL = category_old.getImageURL();
        if(imageURL==null){
            imageURL = categoryService.uploadFile(categoryDTO.getImageURL());
        }
        Category category = new Category(categoryDTO.getCategory_id(), categoryDTO.getName(), imageURL);
        categoryService.saveCategory(category);
        return "redirect:/fooddelivery/category";
    }

    @GetMapping("/destroy/{id}")
    public String deleteCategory(@PathVariable Long id) {
        System.out.println(id);
        categoryService.deleteCategory(id);
        return "redirect:/fooddelivery/category";
    }
}
