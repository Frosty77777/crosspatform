import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constants.dart';
import 'firebase_options.dart';
import 'router.dart';
import 'services/notification_service.dart';
import 'state/theme_manager.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Background handler is where we can react to chat/review data pushes.
  debugPrint('FCM(background): ${message.messageId} data=${message.data}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationService.instance.initialize();
  runApp(const ProviderScope(child: CarRent()));
}

class CarRent extends StatefulWidget {
  const CarRent({super.key});

  @override
  State<CarRent> createState() => _CarRentState();
}

class _CarRentState extends State<CarRent> {
  ColorSelection colorSelected = ColorSelection.pink;
  final ThemeManager _themeManager = ThemeManager();

  void changeColor(int value) {
    setState(() {
      colorSelected = ColorSelection.values[value];
    });
  }

  @override
  void dispose() {
    _themeManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeManagerScope(
      manager: _themeManager,
      child: AnimatedBuilder(
        animation: _themeManager,
        builder: (context, _) => MaterialApp.router(
          // ── Chapter 8: swap MaterialApp for MaterialApp.router ──────────────
          routerConfig: appRouter,
          title: 'Carrent',
          debugShowCheckedModeBanner: false,
          themeMode: _themeManager.themeMode,
          theme: ThemeData(
            colorSchemeSeed: colorSelected.color,
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF7F7F9),
            appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
            cardTheme: CardThemeData(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            navigationBarTheme: NavigationBarThemeData(
              indicatorColor: colorSelected.color.withValues(alpha: 0.15),
              height: 72,
              labelTextStyle: const WidgetStatePropertyAll(
                TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: colorSelected.color,
            useMaterial3: true,
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0),
            cardTheme: CardThemeData(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            navigationBarTheme: NavigationBarThemeData(
              indicatorColor: colorSelected.color.withValues(alpha: 0.30),
              height: 72,
              labelTextStyle: const WidgetStatePropertyAll(
                TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
