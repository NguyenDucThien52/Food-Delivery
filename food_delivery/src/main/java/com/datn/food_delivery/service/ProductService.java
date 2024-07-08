package com.datn.food_delivery.service;

import com.datn.food_delivery.models.Product;
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
public class ProductService {

    public void saveProduct(Product product) throws InterruptedException, ExecutionException {
        Firestore firestore = FirestoreClient.getFirestore();
        DocumentReference docRef = firestore.collection("products").document(String.valueOf(product.getProduct_id()));
        ApiFuture<WriteResult> Result = docRef.set(product);
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

    public List<Product> getProductsByKeyword(String keyword) throws InterruptedException, ExecutionException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("products").get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        List<Product> products = new ArrayList<>();
        for (QueryDocumentSnapshot document : documents){
            Product product = document.toObject(Product.class);
            if(product.getName().toLowerCase().contains(keyword.toLowerCase())){
                product.setProduct_id(Long.parseLong(document.getId()));
                products.add(product);
            }
        }
        return products;
    }

    public String uploadFile(MultipartFile file) throws IOException {
        Bucket bucket = StorageClient.getInstance().bucket();
        String blobName = UUID.randomUUID().toString() + "-" + file.getOriginalFilename();
        Blob blob = bucket.create(blobName, file.getBytes(), file.getContentType());

        blob.createAcl(Acl.of(Acl.User.ofAllUsers(), Acl.Role.READER));

        return blob.getMediaLink();
    }

    public Product getProductByid(long prooduct_id) throws InterruptedException, ExecutionException{
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("products").whereEqualTo("product_id", prooduct_id).get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();
        return documents.get(0).toObject(Product.class);
    }

    public List<Product> getProductsByCartItem(List<Long> product_id) throws InterruptedException, ExecutionException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("products").get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        List<Product> products = new ArrayList<>();
        for (QueryDocumentSnapshot document : documents){
            Product product = document.toObject(Product.class);
            product.setProduct_id(Long.parseLong(document.getId()));
            if(product_id.contains(product.getProduct_id())){
                products.add(product);
            }
        }
        return products;
    }

    public List<Product> getProductsByCategory(Long category_id) throws InterruptedException, ExecutionException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<QuerySnapshot> future = firestore.collection("products").whereEqualTo("category_id", category_id).get();
        List<QueryDocumentSnapshot> documents = future.get().getDocuments();

        List<Product> products = new ArrayList<>();
        for (QueryDocumentSnapshot document : documents){
            Product product = document.toObject(Product.class);
            product.setProduct_id(Long.parseLong(document.getId()));
            products.add(product);
        }
        return products;
    }

    public void deleteProduct(Long product_id){
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> future = firestore.collection("products").document(product_id.toString()).delete();
    }
}
