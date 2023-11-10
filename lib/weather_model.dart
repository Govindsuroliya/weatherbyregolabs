class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final double windSpeed;
  final int humidity;
  final String country;
  final int visibility;
  Weather(
      {required this.cityName,
      required this.country,
      required this.temperature,
      required this.mainCondition,
      required this.visibility,
      required this.humidity,
      required this.windSpeed});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json["name"],
        country: json["sys"]["country"],
        temperature: json["main"]["temp"],
        mainCondition: json["weather"][0]["main"],
        visibility: json["visibility"],
        humidity: json["main"]["humidity"],
        windSpeed: json["wind"]["speed"]);
  }
}
