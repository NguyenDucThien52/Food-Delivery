package com.datn.food_delivery;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

@Configuration
public class FirebaseConfig {



    @Bean
    public FirebaseApp initializeFirebase() throws IOException {
        FileInputStream serviceAccount =
                new FileInputStream("./keyAccountService.json");

        FirebaseOptions options = new FirebaseOptions.Builder()
                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                .setStorageBucket("food-delivery-18948.appspot.com")
                .build();

        return FirebaseApp.initializeApp(options);
    }

//    @Bean
//    public FirebaseApp initializeFirebase() throws IOException {
//
//        String credentialPath = System.getenv("GOOGLE_APPLICATION_CREDENTIALS");
//        if (credentialPath == null) {
//            throw new FileNotFoundException("");
//        }
//
//        FileInputStream serviceAccount =
//                new FileInputStream(credentialPath);
//
//        FirebaseOptions options = new FirebaseOptions.Builder()
//                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
//                .setStorageBucket("food-delivery-18948.appspot.com")
//                .build();
//
//        return FirebaseApp.initializeApp(options);
//    }
}


