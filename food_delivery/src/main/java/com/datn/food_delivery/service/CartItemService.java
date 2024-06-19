package com.datn.food_delivery.service;

import com.datn.food_delivery.models.Cart;
import com.datn.food_delivery.models.CartItem;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class CartItemService {

    public void saveCartItem(CartItem cartItem) throws InterruptedException, ExecutionException{
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference docRef = firestore
                .collection("cartitems")
                .document(String.valueOf(cartItem.getCartItem_id()));
        ApiFuture<WriteResult> Result = docRef.set(cartItem);
    }

    public CartItem getCartItem(Long product_id, Long cart_id) throws InterruptedException, ExecutionException{
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore
                .collection("cartitems")
                .whereEqualTo("cart_id", cart_id)
                .whereEqualTo("product_id", product_id)
                .get();
        List<QueryDocumentSnapshot> document = future.get().getDocuments();
        if(document.isEmpty()){
            return new CartItem(0L, 0 , 0L, 0L);
        }
        return document.get(0).toObject(CartItem.class);
    }

    public List<CartItem> getCartItemByCart(Long cart_id) throws InterruptedException, ExecutionException{
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore
                .collection("cartitems")
                .whereEqualTo("cart_id", cart_id).get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        List<CartItem> cartItems = new  ArrayList<>();
        for(QueryDocumentSnapshot document : documents){
            CartItem cartItem = document.toObject(CartItem.class);
            cartItem.setCartItem_id(Long.parseLong(document.getId()));
            cartItems.add(cartItem);
        }
        return cartItems;
    }

    public void deleteCartItem(Long cartItem_id) throws InterruptedException, ExecutionException{
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> future = firestore.collection("cartitems").document(cartItem_id.toString()).delete();
    }
}
