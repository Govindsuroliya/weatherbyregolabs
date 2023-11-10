import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weatherbyregolabs/components.dart';
import 'package:weatherbyregolabs/constants.dart';
import 'package:weatherbyregolabs/services.dart';
import 'package:weatherbyregolabs/weather_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _weatherService =
      WeatherService(API_KEY: "ac815e8e631d99d07d690672b1b06854");
  Weather? _weather;

  //getting weather
  _gettingWeather() async {
    print(await _weatherService.getLocation());
    String cityName = await _weatherService.getLocation();

    try {
      print(await _weatherService.getWeather(cityName));
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherLogo(String? mainCondition) {
    if (mainCondition == null) return "assets/images/line.png";
    switch (mainCondition.toLowerCase()) {
      case "clear":
        return "assets/images/sun.png";
      case "clouds":
        return "assets/images/cloud.png";
      case "mist":
        return "assets/images/mist.png";
      case "heavy rain":
        return "assets/images/heavyrain.png";
      case "moderate rain":
        return "assets/images/moderaterain.png";
      case "partly cloudy":
        return "assets/images/partlycloudy.png";
      case "smoke":
        return "assets/images/mist.png";
      default:
        return "assets/images/line.png";
    }
  }

  @override
  void initState() {
    super.initState();
    _gettingWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
          opacity: 1.0,
        )),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
          child: SafeArea(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: secColor,
                      size: 28,
                    ),
                    Text(
                      "${_weather?.cityName}, ",
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _weather?.country ?? "",
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                        height: 250,
                        width: 250,
                        child: Image.asset(
                            getWeatherLogo(_weather?.mainCondition))),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _weather?.mainCondition ?? "null",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${_weather?.temperature.round().toString()} °C",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: WeatherCard(
                          textdata: "${_weather?.windSpeed.toString()} Km/h",
                          icondata: "assets/icons/wind.png",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: WeatherCard(
                          textdata: "${_weather?.humidity.toString()}%",
                          icondata: "assets/icons/drop.png",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: WeatherCard(
                          textdata: "${_weather?.visibility.toString()}",
                          icondata: "assets/icons/sun.png",
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}
