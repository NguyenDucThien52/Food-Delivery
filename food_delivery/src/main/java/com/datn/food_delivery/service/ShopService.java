package com.datn.food_delivery.service;

import com.datn.food_delivery.models.Shop;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.cloud.storage.Acl;
import com.google.cloud.storage.Blob;
import com.google.cloud.storage.Bucket;
import com.google.firebase.cloud.FirestoreClient;
import com.google.firebase.cloud.StorageClient;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.ExecutionException;

@Service
public class ShopService {
    public void saveShop(Shop shop) {
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference docRef = firestore.collection("shops").document(String.valueOf(shop.getShop_id()));
        docRef.set(shop);
    }

    public List<Shop> getAllShops() throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> querySnapshot = firestore.collection("shops").get();
        List<QueryDocumentSnapshot> documents = querySnapshot.get().getDocuments();

        List<Shop> shops = new ArrayList<>();
        for (QueryDocumentSnapshot document : documents) {
            Shop shop = document.toObject(Shop.class);
            shop.setShop_id(Long.parseLong(document.getId()));
            shops.add(shop);
        }
        return shops;
    }

    public List<Shop> getShopsByKeyword(String keyword) throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> querySnapshot = firestore.collection("shops").get();
        List<QueryDocumentSnapshot> documents = querySnapshot.get().getDocuments();

        List<Shop> shops = new ArrayList<>();
        for (QueryDocumentSnapshot document : documents) {
            Shop shop = document.toObject(Shop.class);
            if(shop.getName().contains(keyword) || shop.getAddress().contains(keyword)){
                shop.setShop_id(Long.parseLong(document.getId()));
                shops.add(shop);
            }
        }
        return shops;
    }

    public Shop getShopById(Long shop_id) throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> querySnapshot = firestore.collection("shops").whereEqualTo("shop_id", shop_id).get();
        List<QueryDocumentSnapshot> document = querySnapshot.get().getDocuments();
        return document.get(0).toObject(Shop.class);
    }

    public void deleteShop(Long shop_id) throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> writeResult = firestore.collection("shops").document(shop_id.toString()).delete();
    }

    public String uploadFile(MultipartFile file) throws IOException {
        if(file.isEmpty()){
            return null;
        }
        Bucket bucket = StorageClient.getInstance().bucket();
        String blobName = UUID.randomUUID().toString() + "-" + file.getOriginalFilename();
        Blob blob = bucket.create(blobName, file.getBytes(), file.getContentType());

        blob.createAcl(Acl.of(Acl.User.ofAllUsers(), Acl.Role.READER));

        return blob.getMediaLink();
    }
}
