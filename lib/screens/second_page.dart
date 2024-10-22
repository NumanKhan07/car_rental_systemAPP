// second_page.dart
import 'package:flutter/material.dart';
import 'third_page.dart';
import '../models/car.dart';  // Import the Car model

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Create Car instances
    Car ford = Car(
      name: 'Ford Mustang',
      imageUrl: 'assets/images/ford.png',
      pricePerDay: 100.0,
    );

    Car civic = Car(
      name: 'Honda Civic',
      imageUrl: 'assets/images/civic.png',
      pricePerDay: 80.0,
    );

    Car corolla = Car(
      name: 'Toyota Corolla',
      imageUrl: 'assets/images/car.png',
      pricePerDay: 70.0,
    );

    Car suzuki = Car(
      name: 'Suzuki Mehran',
      imageUrl: 'assets/images/Mehran1.png',
      pricePerDay: 50.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Cars'),
      ),
      body: Center(
        child: SingleChildScrollView(  // Ensure scrolling
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCarSection(context, ford),
              buildCarSection(context, civic),
              buildCarSection(context, corolla),
              buildCarSection(context, suzuki),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build each car section
  Widget buildCarSection(BuildContext context, Car car) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Image.asset(
            car.imageUrl,
            width: 300,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(
            car.name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              navigateWithAnimation(context, car);
            },
            child: Text('See ${car.name} Details'),
          ),
        ],
      ),
    );
  }

  // Reusable method to navigate with slide animation
  void navigateWithAnimation(BuildContext context, Car car) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ThirdPage(car: car),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide from the right
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
