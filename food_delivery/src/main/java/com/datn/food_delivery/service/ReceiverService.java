package com.datn.food_delivery.service;

import com.datn.food_delivery.models.Receiver;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

@Service
public class ReceiverService {

    public void saveReceiver(Receiver receiver) {
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference docRef = firestore.collection("receivers").document(String.valueOf(receiver.getReceiver_id()));
        ApiFuture<WriteResult> writeResult = docRef.set(receiver);
    }
}
