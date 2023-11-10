import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weatherbyregolabs/weather_model.dart';

class WeatherService {
  final String API_KEY;
  static const END_POINT_BASE =
      "http://api.openweathermap.org/data/2.5/weather";

  WeatherService({required this.API_KEY});

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
        Uri.parse('$END_POINT_BASE?q=$cityName&appid=$API_KEY&units=metric'));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load weather data");
    }
  }

  Future<String> getLocation() async {
    //getting Location Permission form user.
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    //getting currently location of user.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // convert the location into a list of placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
// extract the city name from the first placemark
    String? city = placemarks[0].locality;

    return city ?? "Can't locate you";
  }
}
