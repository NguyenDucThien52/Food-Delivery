package com.datn.food_delivery.service;

import com.datn.food_delivery.models.User;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class UserService {

    public User getUser(String email) throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore
                .collection("users")
                .whereEqualTo("email", email)
                .get();
        List<QueryDocumentSnapshot> document = future.get().getDocuments();
        return document.get(0).toObject(User.class);
    }

    public void saveUser(User user){
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference docRef = firestore.collection("users").document(user.getEmail());
        ApiFuture<WriteResult> Result = docRef.set(user);
    }
}
