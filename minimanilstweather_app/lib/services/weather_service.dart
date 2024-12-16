import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:minimanilstweather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKeys;

  WeatherService(this.apiKeys);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
        Uri.parse('$BASE_URL?q=$cityName&appid=$apiKeys&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }
    //fetch locvation if permission given
    Position position = await Geolocator.getCurrentPosition(
      //accuracy: LocationAccuracy.high
    );

    //if permission given we will convert the location in city name : step 1 location into a list of placemark objects
    // step 2 : extract the cityname from the first placemark
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    String? city=placemarks[0].locality;

    return city ?? "_ _ _ _ _"; // if the city know we return the city but if not we return a _ _ _ _ _
  }

}
