import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '72c660b41b09d3481e4a9d97a8e80e69'; // Replace with your actual OpenWeatherMap API key

  // Accepts both city and unit (metric/imperial)
  Future<Map<String, dynamic>> fetchWeather(String city, String unit) async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=$unit'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
