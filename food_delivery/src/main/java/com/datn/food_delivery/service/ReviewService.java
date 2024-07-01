package com.datn.food_delivery.service;

import com.datn.food_delivery.models.Review;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class ReviewService {

    public void saveReview(Review review) {
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference docRef = firestore.collection("reviews").document(String.valueOf(review.getReview_id()));
        ApiFuture<WriteResult> Result = docRef.set(review);
    }

    public Review getRate(Long product_id, String email) throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("reviews")
                .whereEqualTo("product_id", product_id)
                .whereEqualTo("email", email)
                .get();
        List<QueryDocumentSnapshot> document = future.get().getDocuments();
        if(document.isEmpty()){
            return new Review(0L,0,"",0L);
        }else{
            return document.get(0).toObject(Review.class);
        }
    }
    public List<Review> getReviews(Long product_id) throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("reviews")
                .whereEqualTo("product_id", product_id)
                .get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        List<Review> reviews = new ArrayList<>();
        for (QueryDocumentSnapshot document : documents) {
            Review review = document.toObject(Review.class);
            review.setReview_id(Long.parseLong(document.getId()));
            reviews.add(review);
        }
        return reviews;
    }
}
