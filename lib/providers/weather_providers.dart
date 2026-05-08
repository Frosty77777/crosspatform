import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/weather.dart';
import '../services/weather_service.dart';

final weatherServiceProvider = Provider<WeatherService>((ref) {
  return WeatherService();
});

final weatherProvider = FutureProvider<Weather>((ref) async {
  final service = ref.watch(weatherServiceProvider);
  return service.fetchWeather();
});

