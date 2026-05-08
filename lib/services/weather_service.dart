import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather.dart';

class WeatherService {
  static const String _endpoint =
      'https://api.openweathermap.org/data/2.5/weather?q=Astana&units=metric&appid=0adb3b28f9f09698c57eb532eee08549';

  Future<Weather> fetchWeather() async {
    final response = await http.get(Uri.parse(_endpoint));
    if (response.statusCode != 200) {
      throw Exception('Weather unavailable');
    }

    final decoded = json.decode(response.body) as Map<String, dynamic>;
    final weatherList = decoded['weather'] as List<dynamic>;
    final weatherData = weatherList.first as Map<String, dynamic>;
    final main = decoded['main'] as Map<String, dynamic>;

    return Weather(
      temp: (main['temp'] as num?)?.toDouble() ?? 0,
      description: (weatherData['description'] as String? ?? '').trim(),
      icon: (weatherData['icon'] as String? ?? '01d').trim(),
      cityName: (decoded['name'] as String? ?? 'Astana').trim(),
    );
  }
}
