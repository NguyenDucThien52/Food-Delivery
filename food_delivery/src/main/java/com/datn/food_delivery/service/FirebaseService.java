package com.datn.food_delivery.service;
import com.datn.food_delivery.models.Cart;
import com.datn.food_delivery.models.Product;
import com.datn.food_delivery.models.User;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import com.google.protobuf.Api;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@Service
public class FirebaseService {

    public void saveUser(User user) throws InterruptedException, ExecutionException {
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference docRef = firestore.collection("users").document(user.getEmail());
        ApiFuture<WriteResult> Result = docRef.set(user);
    }
    public void saveProduct(Product product) throws InterruptedException, ExecutionException {
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference docRef = firestore.collection("products").document(String.valueOf(product.getProduct_id()));
        ApiFuture<WriteResult> Result = docRef.set(product);
    }

    public void saveCart(Cart cart) throws InterruptedException, ExecutionException {
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference cartRef = firestore.collection("carts").document(String.valueOf(cart.getCart_id()));
        ApiFuture<WriteResult> Result = cartRef.set(cart);
    }


    public Cart getCart(String email) throws ExecutionException, InterruptedException{
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("carts").whereEqualTo("email",email).limit(1).get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();
        Cart cart = documents.get(0).toObject(Cart.class);
        return cart;
    }

    public List<User> getUser() throws InterruptedException, ExecutionException{
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("users").get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        List<User> users = new ArrayList<>();
        for(QueryDocumentSnapshot document : documents){
            User user = document.toObject(User.class);
            user.setEmail(user.getEmail());
            users.add(user);
        }
        return users;
    }

    public List<Product> getAllProducts() throws InterruptedException, ExecutionException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("products").get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        List<Product> products = new ArrayList<>();
        for (QueryDocumentSnapshot document : documents){
            Product product = document.toObject(Product.class);
            product.setProduct_id(Long.parseLong(document.getId()));
            products.add(product);
        }
        return products;
    }

    public List<Product> getProductsByCart(List<Long> product_id) throws InterruptedException, ExecutionException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("products").get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        List<Product> products = new ArrayList<>();
        for (QueryDocumentSnapshot document : documents){
            Product product = document.toObject(Product.class);
            product.setProduct_id(Long.parseLong(document.getId()));
            if(product_id.contains(product.getProduct_id())){
//                System.out.println(product.getProduct_id());
                products.add(product);
            }
//            product.setProduct_id(Long.parseLong(document.getId()));
//            products.add(product);
        }
        return products;
    }
}
