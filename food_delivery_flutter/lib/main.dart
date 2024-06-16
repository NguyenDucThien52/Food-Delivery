import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'View/Anonymous/login_page.dart';
// import 'Page/home.dart';

void main() async {
  //Connect firebase
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: 'AIzaSyDKWZUdiJDHjdRz85cvQ3rHjImiXPE1E0g',
          appId: '1:492655248277:android:b14d95cae6e3c7de216c9c',
          messagingSenderId: '492655248277',
          projectId: 'food-delivery-18948',
          storageBucket: "food-delivery-18948.appspot.com",
        ))
      : await Firebase.initializeApp();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]); // hide the navigation bar android
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        themeMode: ThemeMode.light,
        home: LoginPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}
