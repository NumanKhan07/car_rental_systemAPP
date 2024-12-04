import 'package:flutter/material.dart';
import 'weather_screen.dart';  // Import the weather screen
import '../models/car.dart';  // Import the Car model
import '../screens/third_page.dart';
class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  // List of cars
  final List<Car> cars = [
    Car(name: 'Ford Mustang', imageUrl: 'assets/images/ford.png', pricePerDay: 100.0),
    Car(name: 'Honda Civic', imageUrl: 'assets/images/civic.png', pricePerDay: 80.0),
    Car(name: 'Toyota Corolla', imageUrl: 'assets/images/car.png', pricePerDay: 70.0),
    Car(name: 'Suzuki Mehran', imageUrl: 'assets/images/Mehran1.png', pricePerDay: 50.0),
  ];

  // View type (ListView or GridView)
  bool isGridView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Cars'),
        actions: [
          // Toggle button for ListView/GridView
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_on),
            onPressed: () {
              setState(() {
                isGridView = !isGridView; // Toggle between grid and list view
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isGridView ? _buildGridView() : _buildListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Weather screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WeatherScreen()),
          );
        },
        child: Icon(Icons.cloud),
        tooltip: 'Check Weather',
      ),
    );
  }

  // ListView builder
  Widget _buildListView() {
    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (context, index) {
        return _buildCarItem(context, cars[index]);
      },
    );
  }

  // GridView builder
  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,  // You can adjust the number of items per row here
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: cars.length,
      itemBuilder: (context, index) {
        return _buildCarItem(context, cars[index]);
      },
    );
  }

  // Helper method to build each car item
  Widget _buildCarItem(BuildContext context, Car car) {
    return GestureDetector(
      onTap: () {
        // Navigate to the Third Page (Car Details)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ThirdPage(car: car),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Column(
          children: [
            Image.asset(
              car.imageUrl,
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              car.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              '\$${car.pricePerDay.toStringAsFixed(2)}/day',
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
