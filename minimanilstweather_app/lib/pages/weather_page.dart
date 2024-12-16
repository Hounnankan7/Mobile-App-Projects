import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimanilstweather_app/services/weather_service.dart';

import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //api key
  final _weatherService = WeatherService('969df3d51076dabb06489f6c69228c70');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {

    //get current city
    String cityName = await _weatherService.getCurrentCity();
    //get weather
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    //in case of errors
    catch (e) {
      print(e);
    }
  }

  //weather animation
  String getWeatherAnimation(String? mainCondition) {
    if(mainCondition == null){return 'assets/sunny.json';} //default animation to sunny

    switch(mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloud.json';
      case 'mist':
        return 'assets/cloud.json';
      case 'smoke':
        return 'assets/misty.json';
      case 'haze':
        return 'assets/misty.json';
      case 'dust':
        return 'assets/misty.json';
      case 'fog':
        return 'assets/misty.json';
      case 'rain':
        return 'assets/rainning.json';
      case 'drizzle':
        return 'assets/rainning.json';
      case 'shower rain':
        return 'assets/rainning.json';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'clear':
        return 'assets/sunny.json';
      default :
        return 'assets/sunny.json';
    }
  }


  //initial state
  @override
  void initState() {
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }

  @override
  // TODO: implement widget
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //cityName
              Text(_weather?.cityName ?? "Loading city..",
                style: TextStyle(
                  fontSize: 26, // Font size
                  color: Colors.white, // Font color
                  fontWeight: FontWeight.bold, // Bold font
                ),
              ),

              //animation weather
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),


              //temperature
              Text('${_weather?.temperature.round()}°C',
                style: TextStyle(
                  fontSize: 24, // Font size
                  color: Colors.white, // Font color
                  fontWeight: FontWeight.bold, // Bold font
                ),
              ),

              //weather condition
              Text(_weather?.mainCondition ?? "",
                style: TextStyle(
                  fontSize: 18, // Font size
                  color: Colors.white, // Font color
                ),
              ),
            ],
          ),
        ),
    );

  }
}

