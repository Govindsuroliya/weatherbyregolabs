import 'package:flutter/material.dart';
import 'package:weatherbyregolabs/constants.dart';

import 'home.dart';

void main() => runApp(const WeatherApp());

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: appName,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark,useMaterial3: true),
    );
  }
}
