import 'package:flutter/material.dart';
import '../Services/weather_service.dart'; // Import your WeatherService class

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();
  String _city = '';
  Map<String, dynamic>? _weatherData;
  bool _isLoading = false;
  String _unit = 'metric'; // Default unit is Celsius (metric)

  // Unit conversion option - Celsius or Fahrenheit
  void _toggleUnit() {
    setState(() {
      _unit = (_unit == 'metric') ? 'imperial' : 'metric'; // Toggle between metric and imperial
    });
  }

  // Fetch weather data
  void _getWeather() async {
    if (_city.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true; // Show loading indicator
      _weatherData = null; // Reset previous weather data
    });

    try {
      WeatherService weatherService = WeatherService();
      final data = await weatherService.fetchWeather(_city, _unit); // Fetch weather with the selected unit

      setState(() {
        _weatherData = data; // Update weather data
        _isLoading = false; // Hide loading indicator
      });
    } catch (e) {
      setState(() {
        _weatherData = null; // Reset on error
        _isLoading = false; // Hide loading indicator
      });

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching weather: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(
            icon: Icon(_unit == 'metric' ? Icons.thermostat_outlined : Icons.device_thermostat),
            onPressed: _toggleUnit, // Toggle between Celsius and Fahrenheit
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // City input field
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.location_city),
              ),
              onChanged: (value) {
                setState(() {
                  _city = value;  // Update city name on change
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getWeather,
              child: Text('Get Weather'),
            ),
            SizedBox(height: 16),
            // Show loading spinner while fetching data
            if (_isLoading)
              Center(child: CircularProgressIndicator()),
            // Show weather data or a message
            _weatherData == null
                ? Center(child: Text('Enter a city to get weather information.'))
                : _buildWeatherInfo(),
          ],
        ),
      ),
    );
  }

  // Method to build the weather information UI
  Widget _buildWeatherInfo() {
    return Column(
      children: [
        Text(
          'City: ${_weatherData!['name']}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Temperature: ${_weatherData!['main']['temp']}° ${_unit == 'metric' ? 'C' : 'F'}',
          style: TextStyle(fontSize: 22),
        ),
        SizedBox(height: 10),
        Text(
          'Weather: ${_weatherData!['weather'][0]['description']}',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 10),
        // Show weather icon
        Image.network(
          'https://openweathermap.org/img/wn/${_weatherData!['weather'][0]['icon']}@2x.png',
          width: 100,
          height: 100,
        ),
        SizedBox(height: 20),
        // Additional weather information
        _buildAdditionalInfo(),
      ],
    );
  }

  // Method to display additional weather information (humidity, wind speed)
  Widget _buildAdditionalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Humidity: ${_weatherData!['main']['humidity']}%',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 5),
        Text(
          'Wind Speed: ${_weatherData!['wind']['speed']} m/s',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
