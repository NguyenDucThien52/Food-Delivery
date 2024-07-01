package com.datn.food_delivery.service;

import com.datn.food_delivery.models.FavoriteShop;
import com.datn.food_delivery.models.Shop;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.concurrent.ExecutionException;

@Service
public class FavoriteShopService {
    public void saveFavoriteShop(FavoriteShop favoriteShop) {
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference docRef = firestore.collection("favorite_shops").document();
        docRef.set(favoriteShop);
    }

    public void deleteFavoriteShop(Long favoriteShop_id) throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> writeResult = firestore.collection("favorite_shops").document(String.valueOf(favoriteShop_id)).delete();
    }
}
