import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopx/controllers/authcontroller.dart';
import 'package:shopx/views/auth/welcomepage.dart';
import 'package:shopx/views/home/homepage.dart';
import 'package:shopx/views/auth/loginpage.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDIjbpGA1lf4SSarVykIcE0PMLhZkDVnII",
        appId: "1:530803562588:android:acc77730d3c3922dc06e99",
        messagingSenderId: "530803562588",
        projectId: "flutterdemo-53872",
        storageBucket: "flutterdemo-53872.appspot.com",
      ),
    );
  } catch (e) {
    print('Failed to initialize Firebase: $e');
    // Handle the error as needed, e.g., show a dialog or retry initialization.
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authController = Get.put(AuthController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // GetMaterialApp because we need to use Get.to and all
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
      //    WelcomePage()
      Obx(() {
       return authController.isLoggedIn.value ? Homepage() : WelcomePage();
       // return const WelcomePage();
      })
      ,
    );
  }
}
