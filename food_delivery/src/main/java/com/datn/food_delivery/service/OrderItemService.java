package com.datn.food_delivery.service;

import com.datn.food_delivery.models.OrderItem;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Service
public class OrderItemService {

    public void saveOrderItem(OrderItem orderItem) {
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference docRef = firestore
                .collection("orderitems")
                .document(String.valueOf(orderItem.getOrder_id()));
        ApiFuture<WriteResult> writeResult = docRef.set(orderItem);
    }

    public List<OrderItem> getAllOrderItemsByOrderId(Long order_id) throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("orderitems").whereEqualTo("order_id", order_id).get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        List<OrderItem> orderItems = new ArrayList<>();
        for (QueryDocumentSnapshot document : documents) {
            OrderItem orderItem = document.toObject(OrderItem.class);
            orderItem.setOrder_id(Long.parseLong(document.getId()));
            orderItems.add(orderItem);
        }
        return orderItems;
    }
}
