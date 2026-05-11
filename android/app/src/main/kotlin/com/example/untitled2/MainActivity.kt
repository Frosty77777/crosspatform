package com.example.untitled2

import android.content.Context
import android.os.BatteryManager
import android.os.Build
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * Chapter 17 — Platform Channels (Android / Kotlin side)
 *
 * The CHANNEL string must match the one declared in
 * `lib/services/device_info_service.dart` exactly.
 *
 * `configureFlutterEngine` is the recommended hook to register handlers
 * because the engine (and BinaryMessenger) are guaranteed to be ready.
 */
class MainActivity : FlutterActivity() {

    companion object {
        private const val CHANNEL = "com.example.untitled2/device"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getBatteryLevel" -> {
                        val level = getBatteryLevel()
                        if (level >= 0) {
                            result.success(level)
                        } else {
                            result.error(
                                "UNAVAILABLE",
                                "Battery level not available.",
                                null
                            )
                        }
                    }

                    "getDeviceInfo" -> {
                        // Return a HashMap — Flutter auto-converts to Dart Map.
                        val info = hashMapOf<String, Any>(
                            "manufacturer" to Build.MANUFACTURER,
                            "model" to Build.MODEL,
                            "sdkInt" to Build.VERSION.SDK_INT,
                            "release" to Build.VERSION.RELEASE
                        )
                        result.success(info)
                    }

                    "showToast" -> {
                        // Reading arguments sent from Dart.
                        val message = call.argument<String>("message")
                        val long = call.argument<Boolean>("long") ?: false
                        if (message.isNullOrBlank()) {
                            result.error(
                                "BAD_ARGS",
                                "Argument 'message' is required.",
                                null
                            )
                        } else {
                            Toast.makeText(
                                this,
                                message,
                                if (long) Toast.LENGTH_LONG else Toast.LENGTH_SHORT
                            ).show()
                            result.success(null)
                        }
                    }

                    else -> result.notImplemented()
                }
            }
    }

    /** Reads the current battery percentage using Android's BatteryManager. */
    private fun getBatteryLevel(): Int {
        val batteryManager =
            getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }
}
