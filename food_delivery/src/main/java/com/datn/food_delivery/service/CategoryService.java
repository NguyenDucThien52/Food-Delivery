package com.datn.food_delivery.service;

import com.datn.food_delivery.models.Category;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.cloud.storage.Acl;
import com.google.cloud.storage.Blob;
import com.google.cloud.storage.Bucket;
import com.google.firebase.cloud.FirestoreClient;
import com.google.firebase.cloud.StorageClient;
import com.google.protobuf.Api;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

@Service
public class CategoryService {
    public void saveCategory(Category category) {
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference docRef = firestore
                .collection("categories")
                .document(String.valueOf(category.getCategory_id()));
        docRef.set(category);
    }

    public List<Category> getAllCategory() throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("categories").get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        List<Category> categories = new ArrayList<>();
        for (QueryDocumentSnapshot document : documents) {
            Category category = document.toObject(Category.class);
            category.setCategory_id(Long.parseLong(document.getId()));
            categories.add(category);
        }
        return categories;
    }

    public Category getCategoryById(Long category_id) throws ExecutionException, InterruptedException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("categories").whereEqualTo("category_id", category_id).get();
        List<QueryDocumentSnapshot> document = future.get().getDocuments();
        return document.get(0).toObject(Category.class);
    }

    public void deleteCategory(Long category_id) {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> future =  firestore.collection("categories").document(category_id.toString()).delete();
    }

    public String uploadFile(MultipartFile file) throws IOException {
        Bucket bucket = StorageClient.getInstance().bucket();
        String blobName = UUID.randomUUID().toString() + "-" + file.getOriginalFilename();
        Blob blob = bucket.create(blobName, file.getBytes(), file.getContentType());

        blob.createAcl(Acl.of(Acl.User.ofAllUsers(), Acl.Role.READER));

        return blob.getMediaLink();
    }

}
