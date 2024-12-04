import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/first_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBi8ejlfmVRRAcpyhvfypI0r_U1vIUIiec",
      authDomain: "carrentalsystem-6ff4b.firebaseapp.com",
      projectId: "carrentalsystem-6ff4b",
      storageBucket: "carrentalsystem-6ff4b.appspot.com",
      messagingSenderId: "410429323012",
      appId: "1:410429323012:web:7f0feecb0df9bbc20d8251",
      measurementId: "G-JCP0TXNBMS",
    ),
  );
  runApp(CarRentalApp());
}

class CarRentalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Rental System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(), // Calling the FirstPage widget
      debugShowCheckedModeBanner: false, // Hide the debug banner
    );
  }
}