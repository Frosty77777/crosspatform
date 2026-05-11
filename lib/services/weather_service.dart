import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather.dart';

/// Fetches current weather from OpenWeatherMap.
///
/// The [http.Client] is injectable so tests can pass a `MockClient`
/// (from `package:http/testing.dart`) and run without a network call.
/// In production, callers can omit it and we use a default client.
class WeatherService {
  WeatherService({http.Client? client}) : _client = client ?? http.Client();

  static const String _endpoint =
      'https://api.openweathermap.org/data/2.5/weather?q=Astana&units=metric&appid=0adb3b28f9f09698c57eb532eee08549';

  final http.Client _client;

  Future<Weather> fetchWeather() async {
    final response = await _client.get(Uri.parse(_endpoint));
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
