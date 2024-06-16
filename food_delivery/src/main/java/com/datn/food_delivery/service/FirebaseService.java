package com.datn.food_delivery.service;
import com.datn.food_delivery.models.Product;
import com.datn.food_delivery.models.User;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class FirebaseService {

    public void saveUser(User user) throws InterruptedException, ExecutionException {
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference docRef = firestore.collection("users").document(String.valueOf(user.getUser_id()));
        ApiFuture<WriteResult> Result = docRef.set(user);
    }

    public User getUser() throws InterruptedException, ExecutionException{
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("users").get();
        QueryDocumentSnapshot document = (QueryDocumentSnapshot) future.get().getDocuments();

        User user = document.toObject(User.class);
        return user;
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
            System.out.println(product.getName() + "\n");
        }
        return products;
    }

    public void saveProdct(Product product) throws InterruptedException, ExecutionException {
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference docRef = firestore.collection("products").document(String.valueOf(product.getProduct_id()));
        ApiFuture<WriteResult> Result = docRef.set(product);
    }
}
