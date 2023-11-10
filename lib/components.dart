import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String textdata;
  final String icondata;
  const WeatherCard(
      {required this.icondata, required this.textdata, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 110,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Color.fromARGB(121, 187, 187, 187)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child:
                SizedBox(height: 40, width: 40, child: Image.asset(icondata)),
          ),
          Text(
            textdata,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
