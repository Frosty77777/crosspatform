import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';

class UserManager extends ChangeNotifier {
  final AuthService _authService;
  User? _firebaseUser;
  late final Stream<User?> _authStateStream;

  UserManager({AuthService? authService})
    : _authService = authService ?? AuthService() {
    _authStateStream = _authService.authStateChanges();
    _authStateStream.listen((user) {
      _firebaseUser = user;
      notifyListeners();
    });
  }

  bool get isLoggedIn => _firebaseUser != null;
  String get username => _firebaseUser?.email ?? '';

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _authService.signIn(email: email, password: password);
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    await _authService.signUp(email: email, password: password);
  }

  Future<void> logout() async {
    await _authService.signOut();
  }
}
