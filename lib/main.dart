import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather App',
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String apiKey = 'YOUR_API_KEY'; 
  // Replace with your OpenWeatherMap API key
  String city = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                city = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Enter a city',
            ),
          ),
          ElevatedButton(
            onPressed: () {
                fetchWeatherData();
          },
            child: const Text('Get Weather'),
          ),
          // Display weather data here using ListView

          if (currentWeatherData.isNotEmpty)
            Column(
              children: [
                Text('City: ${currentWeatherData['name']}'),
                Text(
                    'Temperature: ${currentWeatherData['main']['temp']}°C'),
                Text(
                    'Description: ${currentWeatherData['weather'][0]['description']}'),
              ],
            ),

        ],
      ),
    );
  }

  Map<String, dynamic> currentWeatherData = {};
  Future<void>fetchWeatherData() async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=ceb81ad2f496abb5885dda297996e824')
    );
    if (response.statusCode == 200) {
      setState(() {
        currentWeatherData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load weather data');
      }
  } 
}
