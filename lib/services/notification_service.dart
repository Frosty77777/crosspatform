import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _highImportanceChannel =
      AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'Used for important car rent notifications.',
        importance: Importance.high,
      );

  Future<void> initialize() async {
    await _requestPermission();
    await _initializeLocalNotifications();
    await _initializeFirebaseMessagingHandlers();
    final token = await _messaging.getToken();
    // Token is needed for manual FCM testing in Firebase console.
    debugPrint('FCM Token: $token');
  }

  Future<void> _requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
  }

  Future<void> _initializeLocalNotifications() async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        _handlePayload(details.payload);
      },
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_highImportanceChannel);
  }

  Future<void> _initializeFirebaseMessagingHandlers() async {
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((message) async {
      await _showForegroundNotification(message);
      _handleRemoteMessageData(message, source: 'foreground');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleRemoteMessageData(message, source: 'background_opened');
    });

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleRemoteMessageData(initialMessage, source: 'terminated_opened');
    }
  }

  Future<void> _showForegroundNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;
    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _highImportanceChannel.id,
          _highImportanceChannel.name,
          channelDescription: _highImportanceChannel.description,
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }

  void _handlePayload(String? payload) {
    if (payload == null || payload.isEmpty) return;
    final data = jsonDecode(payload) as Map<String, dynamic>;
    _handleNotificationData(data, source: 'local_payload');
  }

  /// Handles data payloads for both review and chat notifications.
  /// - `type == chat_message` can be used to open support chat UI.
  /// - `type == new_review` can be used to highlight latest car reviews.
  void _handleRemoteMessageData(RemoteMessage message, {required String source}) {
    _handleNotificationData(message.data, source: source);
  }

  void _handleNotificationData(
    Map<String, dynamic> data, {
    required String source,
  }) {
    final type = data['type'] as String?;
    if (type == 'chat_message') {
      debugPrint('FCM($source): chat notification data -> $data');
      return;
    }
    if (type == 'new_review') {
      debugPrint('FCM($source): review notification data -> $data');
      return;
    }
    debugPrint('FCM($source): generic notification data -> $data');
  }
}
