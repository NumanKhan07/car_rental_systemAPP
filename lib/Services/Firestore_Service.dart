import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch all documents from a collection (e.g., 'cars')
  Future<List<Map<String, dynamic>>> fetchCars() async {
    try {
      final snapshot = await _db.collection('cars').get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Error fetching cars: $e');
    }
  }

  // Add a new car document
  Future<void> addCar(Map<String, dynamic> carData) async {
    try {
      await _db.collection('cars').add(carData);
    } catch (e) {
      throw Exception('Error adding car: $e');
    }
  }

  // Update an existing car document by ID
  Future<void> updateCar(String carId, Map<String, dynamic> carData) async {
    try {
      await _db.collection('cars').doc(carId).update(carData);
    } catch (e) {
      throw Exception('Error updating car: $e');
    }
  }

  // Delete a car document by ID
  Future<void> deleteCar(String carId) async {
    try {
      await _db.collection('cars').doc(carId).delete();
    } catch (e) {
      throw Exception('Error deleting car: $e');
    }
  }
}
