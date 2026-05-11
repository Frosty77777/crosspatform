// Chapter 18 — Mocking an HTTP service.
//
// WeatherService calls api.openweathermap.org. We cannot rely on the
// real network in unit tests (slow, flaky, may be offline, and we don't
// want to leak the API key in CI logs).
//
// Solution: inject a `MockClient` from `package:http/testing.dart`.
// MockClient lets us register a handler that returns whatever response
// body / status code we want — the service code path is exercised, but
// no real network call is made.

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:untitled2/services/weather_service.dart';

void main() {
  group('WeatherService.fetchWeather (mocked HTTP)', () {
    test('parses a successful 200 response into a Weather object', () async {
      final mockClient = MockClient((request) async {
        // Assert the service is hitting the expected endpoint.
        expect(request.url.host, 'api.openweathermap.org');
        expect(request.method, 'GET');

        return http.Response(
          jsonEncode({
            'weather': [
              {'description': 'clear sky', 'icon': '01d'},
            ],
            'main': {'temp': 21.5},
            'name': 'Astana',
          }),
          200,
        );
      });

      final service = WeatherService(client: mockClient);
      final weather = await service.fetchWeather();

      expect(weather.temp, 21.5);
      expect(weather.description, 'clear sky');
      expect(weather.icon, '01d');
      expect(weather.cityName, 'Astana');
    });

    test('throws when the server returns a non-200 status code', () async {
      final mockClient = MockClient(
        (request) async => http.Response('Internal Server Error', 500),
      );
      final service = WeatherService(client: mockClient);

      expect(service.fetchWeather(), throwsA(isA<Exception>()));
    });

    test('falls back to safe defaults on missing/empty fields (edge case)',
        () async {
      final mockClient = MockClient(
        (_) async => http.Response(
          jsonEncode({
            'weather': [
              {}, // missing description and icon
            ],
            'main': {}, // missing temp
            // 'name' missing entirely
          }),
          200,
        ),
      );
      final service = WeatherService(client: mockClient);

      final weather = await service.fetchWeather();

      expect(weather.temp, 0);
      expect(weather.description, isEmpty);
      expect(weather.icon, '01d', reason: 'default icon');
      expect(weather.cityName, 'Astana', reason: 'default city');
    });

    test('throws when the body is not valid JSON', () async {
      final mockClient =
          MockClient((_) async => http.Response('not-json', 200));
      final service = WeatherService(client: mockClient);

      expect(service.fetchWeather(), throwsA(isA<FormatException>()));
    });
  });
}
