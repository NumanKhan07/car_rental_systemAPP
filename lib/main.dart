// main.dart
import 'package:flutter/material.dart';
import 'screens/first_page.dart';

void main() {
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
      home: FirstPage(), // Start with the first page
      debugShowCheckedModeBanner: false,
    );
  }
}
