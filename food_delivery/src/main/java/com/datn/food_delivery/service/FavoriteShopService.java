package com.datn.food_delivery.service;

import com.datn.food_delivery.models.FavoriteShop;
import com.datn.food_delivery.models.Shop;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class FavoriteShopService {

    public FavoriteShop favoriteShop(Long shop_id, String email) throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore
                .collection("favorite_shops")
                .whereEqualTo("shop_id", shop_id)
                .whereEqualTo("email", email)
                .get();
        List<QueryDocumentSnapshot> document = future.get().getDocuments();
        if(document.isEmpty()){
            return new  FavoriteShop(0L, 0L, "");
        }
        return document.get(0).toObject(FavoriteShop.class);
    }

    public void saveFavoriteShop(FavoriteShop favoriteShop) {
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference docRef = firestore.collection("favorite_shops").document(String.valueOf(favoriteShop.getFavoriteShop_id()));
        docRef.set(favoriteShop);
    }

    public void deleteFavoriteShop(Long favoriteShop_id) throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> writeResult = firestore.collection("favorite_shops").document(String.valueOf(favoriteShop_id)).delete();
    }
}
