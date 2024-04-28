import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/model/city_weather_model.dart';
import 'package:weather_app/pages/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black45,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Weather ',
              style: TextStyle(fontSize: 30, color: Colors.blue),
            ),
            CircularProgressIndicator(
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }

  String cityName = 'Dubai';
  Future<void> getDataFromAPI() async {
    Response response = await Dio().get(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&lang=fa&&units=metric&appid=604a5a2d0698e550e7ef5281689d43b5');
    Map<String, dynamic> jsonMapObject = response.data;
    CityWeatherModel cityWeather = CityWeatherModel.fromMap(jsonMapObject);
    Future.delayed(const Duration(seconds: 1), () {
      HomeScreen(cityWeather: cityWeather);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(cityWeather: cityWeather),
          ));
    });
  }
}
