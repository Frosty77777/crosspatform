// Unit tests for `WeatherService` — mocked HTTP.
//
// `WeatherService` reaches a real API in production. To test it we
// inject a `MockClient` from `package:http/testing.dart`. No network
// call is performed and no API key is exposed.
//
// All test bodies follow Arrange / Act / Assert.

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:untitled2/services/weather_service.dart';

void main() {
  group('WeatherService', () {
    group('fetchWeather()', () {
      test('parses a successful 200 response into a Weather object',
          () async {
        // Arrange
        final mockClient = MockClient((request) async {
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

        // Act
        final weather = await service.fetchWeather();

        // Assert
        expect(weather.temp, 21.5);
        expect(weather.description, 'clear sky');
        expect(weather.icon, '01d');
        expect(weather.cityName, 'Astana');
      });

      test('throws when the server returns a non-200 status code',
          () async {
        // Arrange
        final mockClient = MockClient(
          (request) async => http.Response('Internal Server Error', 500),
        );
        final service = WeatherService(client: mockClient);

        // Act + Assert — invoking the method must throw.
        expect(service.fetchWeather(), throwsA(isA<Exception>()));
      });

      test(
        'falls back to safe defaults on missing/empty fields (edge case)',
        () async {
          // Arrange
          final mockClient = MockClient(
            (_) async => http.Response(
              jsonEncode({
                'weather': [<String, dynamic>{}],
                'main': <String, dynamic>{},
              }),
              200,
            ),
          );
          final service = WeatherService(client: mockClient);

          // Act
          final weather = await service.fetchWeather();

          // Assert
          expect(weather.temp, 0);
          expect(weather.description, isEmpty);
          expect(weather.icon, '01d');
          expect(weather.cityName, 'Astana');
        },
      );

      test('throws FormatException when the body is not valid JSON',
          () async {
        // Arrange
        final mockClient =
            MockClient((_) async => http.Response('not-json', 200));
        final service = WeatherService(client: mockClient);

        // Act + Assert
        expect(service.fetchWeather(), throwsA(isA<FormatException>()));
      });
    });
  });
}
