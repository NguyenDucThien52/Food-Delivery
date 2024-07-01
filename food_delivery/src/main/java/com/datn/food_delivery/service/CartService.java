package com.datn.food_delivery.service;

import com.datn.food_delivery.models.Cart;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class CartService {

    public void saveCart(Cart cart) throws InterruptedException, ExecutionException {
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference cartRef = firestore.collection("carts").document(String.valueOf(cart.getCart_id()));
        ApiFuture<WriteResult> Result = cartRef.set(cart);
    }


    public Cart getCart(String email) throws ExecutionException, InterruptedException{
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> userFutures = firestore.collection("users").whereEqualTo("email", email).get();
        List<QueryDocumentSnapshot> document = userFutures.get().getDocuments();
        ApiFuture<QuerySnapshot> future = firestore.collection("carts").whereEqualTo("email",email).limit(1).get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();
        Cart cart = documents.get(0).toObject(Cart.class);
        return cart;
    }
}
