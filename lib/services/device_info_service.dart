import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Chapter 17 — Platform Channels
///
/// Bridges Dart with native Android (Kotlin) code via a [MethodChannel].
///
/// The channel name MUST match exactly on both sides:
///   • Dart side  → [DeviceInfoService._channel] below
///   • Native side → `MainActivity.kt` (`CHANNEL` constant)
///
/// All methods return a [Future] because the call hops to the platform
/// thread, executes native code, and hops back. Errors raised on the
/// native side surface here as [PlatformException].
class DeviceInfoService {
  DeviceInfoService._();
  static final DeviceInfoService instance = DeviceInfoService._();

  static const MethodChannel _channel = MethodChannel(
    'com.example.untitled2/device',
  );

  /// Returns the current battery level as a percentage (0–100).
  ///
  /// Throws [PlatformException] if native code fails, or
  /// [UnsupportedError] if running on a platform we have not implemented.
  Future<int> getBatteryLevel() async {
    _ensureSupported();
    try {
      final int level = await _channel.invokeMethod<int>('getBatteryLevel')
          ?? -1;
      return level;
    } on PlatformException catch (e) {
      debugPrint('PlatformChannel error (getBatteryLevel): ${e.message}');
      rethrow;
    }
  }

  /// Returns device information from `android.os.Build`.
  ///
  /// Result map keys: `manufacturer`, `model`, `sdkInt`, `release`.
  Future<Map<String, dynamic>> getDeviceInfo() async {
    _ensureSupported();
    try {
      final result = await _channel.invokeMapMethod<String, dynamic>(
        'getDeviceInfo',
      );
      return result ?? const {};
    } on PlatformException catch (e) {
      debugPrint('PlatformChannel error (getDeviceInfo): ${e.message}');
      rethrow;
    }
  }

  /// Demonstrates passing arguments from Dart → Native.
  /// The native side will show a system Toast with the given [message].
  Future<void> showNativeToast(String message, {bool long = false}) async {
    _ensureSupported();
    try {
      await _channel.invokeMethod<void>('showToast', <String, dynamic>{
        'message': message,
        'long': long,
      });
    } on PlatformException catch (e) {
      debugPrint('PlatformChannel error (showToast): ${e.message}');
      rethrow;
    }
  }

  void _ensureSupported() {
    if (kIsWeb) {
      throw UnsupportedError(
        'Platform channels are not available on Flutter Web.',
      );
    }
    if (!(defaultTargetPlatform == TargetPlatform.android)) {
      throw UnsupportedError(
        'This example only implements the Android side. '
        'Add iOS handlers in AppDelegate.swift to support iOS.',
      );
    }
  }
}
