package com.datn.food_delivery.service;

import com.datn.food_delivery.models.FavoriteFood;
import com.datn.food_delivery.models.Product;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class FavoriteFoodService {

    public List<FavoriteFood> getAllFavoriteFoods() throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("favorite_foods").get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        List<FavoriteFood> favoriteFoods = new ArrayList<>();
        for (QueryDocumentSnapshot document : documents) {
            FavoriteFood favoriteFood = document.toObject(FavoriteFood.class);
            favoriteFood.setFavoriteFood_id(Long.parseLong(document.getId()));
            favoriteFoods.add(favoriteFood);
        }
        return favoriteFoods;
    }
}
