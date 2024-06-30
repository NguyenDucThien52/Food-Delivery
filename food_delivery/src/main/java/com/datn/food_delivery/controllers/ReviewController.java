package com.datn.food_delivery.controllers;

import com.datn.food_delivery.models.Review;
import com.datn.food_delivery.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping(path = "/api/reviews")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @GetMapping("")
    public List<Review> getAllReviews(@RequestParam Long product_id) throws ExecutionException, InterruptedException {
        return reviewService.getReviews(product_id);
    }

    @GetMapping("/getreviewbyproductandemail")
    public Review getReviewByProductId(@RequestParam Long product_id,@RequestParam String email) throws ExecutionException, InterruptedException {
        return reviewService.getRate(product_id, email);
    }

    @PostMapping("/insert")
    public void insertReview(@RequestBody Review review){
        reviewService.saveReview(review);
    }
}
