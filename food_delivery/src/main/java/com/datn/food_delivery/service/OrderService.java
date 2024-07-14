package com.datn.food_delivery.service;

import com.datn.food_delivery.models.Order;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class OrderService {
    public void saveOrder(Order order) {
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference docRef = firestore
                .collection("orders")
                .document(String.valueOf(order.getOrder_id()));
        ApiFuture<WriteResult> writeResult = docRef.set(order);
    }
    public List<Order> getAllOrderbyEmail(String email) throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("orders").whereEqualTo("email",email).get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        List<Order> orders = new ArrayList<>();
        for (QueryDocumentSnapshot document : documents) {
            Order order = document.toObject(Order.class);
            order.setOrder_id(Long.parseLong(document.getId()));
            orders.add(order);
        }
        return orders;
    }

    public List<Order> getAllOrder() throws ExecutionException, InterruptedException{
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("orders").get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        List<Order> orders = new ArrayList<>();
        for (QueryDocumentSnapshot document : documents) {
            Order order = document.toObject(Order.class);
            order.setOrder_id(Long.parseLong(document.getId()));
            orders.add(order);
        }
        return orders;
    }
}
