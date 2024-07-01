package com.datn.food_delivery.service;

import com.datn.food_delivery.models.FavoriteFood;
import com.datn.food_delivery.models.Product;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import com.google.protobuf.Api;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class FavoriteFoodService {

    public List<FavoriteFood> getAllFavoriteFoods(String email) throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("favorite_foods")
                .whereEqualTo("email", email)
                .get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        List<FavoriteFood> favoriteFoods = new ArrayList<>();
        for (QueryDocumentSnapshot document : documents) {
            FavoriteFood favoriteFood = document.toObject(FavoriteFood.class);
            favoriteFood.setFavoriteFood_id(Long.parseLong(document.getId()));
            favoriteFoods.add(favoriteFood);
        }
        return favoriteFoods;
    }

    public FavoriteFood getFavoriteFood(String email, Long product_id) throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("favorite_foods")
                .whereEqualTo("email", email)
                .whereEqualTo("product_id", product_id)
                .get();
        List<QueryDocumentSnapshot> document = future.get().getDocuments();
        if(document.isEmpty()){
            return new FavoriteFood(0L, 0L, "");
        }
        return document.get(0).toObject(FavoriteFood.class);
    }

    public void insertFavoriteFood(FavoriteFood favoriteFood) {
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference docRef = firestore.collection("favorite_foods").document(String.valueOf(favoriteFood.getFavoriteFood_id()));
        docRef.set(favoriteFood);
    }

    public void deleteFavoriteFood(Long favoriteFood_id) throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> future = firestore.collection("favorite_foods").document(String.valueOf(favoriteFood_id)).delete();
    }
}
