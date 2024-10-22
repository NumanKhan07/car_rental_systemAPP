// third_page.dart
import 'package:flutter/material.dart';
import '../models/car.dart';  // Import the Car model

class ThirdPage extends StatelessWidget {
  final Car car;

  ThirdPage({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${car.name} Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              car.imageUrl,
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              car.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Price per day: \$${car.pricePerDay}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the previous page
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
