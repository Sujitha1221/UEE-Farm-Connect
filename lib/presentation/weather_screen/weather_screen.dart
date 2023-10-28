import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  Location().requestPermission();
  runApp(MyApp());
}

class WeatherData {
  final String description;
  final double temperature;

  WeatherData({required this.description, required this.temperature});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      description: json['weather'][0]['main'],
      temperature: json['main']['temp'].toDouble(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final Location location = Location();
  WeatherData? weatherData;

  @override
  void initState() {
    super.initState();
    _getLocationAndWeather();
  }

  Future<void> _getLocationAndWeather() async {
    try {
      final LocationData locationData = await location.getLocation();
      final double lat = locationData.latitude!;
      final double lon = locationData.longitude!;
      final apiKey = '64786c240fe094e225703485e3b14856';

      final response = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final WeatherData weather = WeatherData.fromJson(data);

        setState(() {
          weatherData = weather;
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Location Weather'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (weatherData != null)
              Text(
                'Weather: ${weatherData!.description}',
                style: TextStyle(fontSize: 24),
              ),
            if (weatherData != null)
              Text(
                'Temperature: ${weatherData!.temperature.toStringAsFixed(1)}°C',
                style: TextStyle(fontSize: 24),
              ),
            if (weatherData == null)
              CircularProgressIndicator(), // Loading indicator
          ],
        ),
      ),
    );
  }
}
