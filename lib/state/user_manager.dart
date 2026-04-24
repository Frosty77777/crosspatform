import 'package:flutter/foundation.dart';

class UserManager extends ChangeNotifier {
  String? _username;

  bool get isLoggedIn => _username != null && _username!.isNotEmpty;
  String get username => _username ?? '';

  void login({required String username, required String password}) {
    // Demo auth: accept any non-empty credentials.
    if (username.trim().isEmpty || password.isEmpty) return;
    _username = username.trim();
    notifyListeners();
  }

  void logout() {
    _username = null;
    notifyListeners();
  }
}

