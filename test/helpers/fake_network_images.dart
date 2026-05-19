// Test helper — makes every `Image.network` resolve to a 1×1 transparent
// PNG so widget/golden tests can render without hitting the real
// network.
//
// We can't simply use `HttpOverrides.global` because Flutter's
// `NetworkImage` caches a static `HttpClient` at class load (it ignores
// later changes to `HttpOverrides.global`). Flutter exposes
// `debugNetworkImageHttpClientProvider` for this exact case — it
// overrides the network-image HTTP client just for the duration of a
// test.

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

/// Call from `setUp(...)` (or once at the top of a test) to make every
/// `Image.network` produce a 1×1 transparent PNG.
void installFakeNetworkImages() {
  debugNetworkImageHttpClientProvider = () => _TransparentPngHttpClient();
}

/// Optional: call from `tearDown(...)` to restore the default client.
void uninstallFakeNetworkImages() {
  debugNetworkImageHttpClientProvider = null;
}

class _TransparentPngHttpClient extends Fake implements HttpClient {
  @override
  bool autoUncompress = true;

  @override
  Duration? connectionTimeout;

  @override
  Duration idleTimeout = const Duration(seconds: 15);

  @override
  String? userAgent;

  @override
  Future<HttpClientRequest> getUrl(Uri url) async =>
      _TransparentPngHttpClientRequest();

  @override
  void close({bool force = false}) {}
}

class _TransparentPngHttpClientRequest extends Fake
    implements HttpClientRequest {
  @override
  final HttpHeaders headers = _FakeHttpHeaders();

  @override
  Future<HttpClientResponse> close() async =>
      _TransparentPngHttpClientResponse();

  @override
  void abort([Object? exception, StackTrace? stackTrace]) {}
}

class _TransparentPngHttpClientResponse extends Fake
    implements HttpClientResponse {
  @override
  int get statusCode => 200;

  @override
  int get contentLength => _kTransparentPng.length;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.value(_kTransparentPng).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

class _FakeHttpHeaders extends Fake implements HttpHeaders {
  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {}
}

// 1×1 fully transparent PNG.
final Uint8List _kTransparentPng = Uint8List.fromList(<int>[
  0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a, //
  0x00, 0x00, 0x00, 0x0d, 0x49, 0x48, 0x44, 0x52, //
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, //
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1f, 0x15, 0xc4, //
  0x89, 0x00, 0x00, 0x00, 0x0a, 0x49, 0x44, 0x41, //
  0x54, 0x78, 0x9c, 0x63, 0x00, 0x01, 0x00, 0x00, //
  0x05, 0x00, 0x01, 0x0d, 0x0a, 0x2d, 0xb4, 0x00, //
  0x00, 0x00, 0x00, 0x49, 0x45, 0x4e, 0x44, 0xae, //
  0x42, 0x60, 0x82, //
]);
