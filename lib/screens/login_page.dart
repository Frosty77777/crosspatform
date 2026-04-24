import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../state/app_state_scope.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final state = AppStateScope.of(context);
    state.user.login(
      username: _usernameController.text,
      password: _passwordController.text,
    );
    if (state.user.isLoggedIn) {
      context.go('/explore');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.bounceOut,
                  builder: (context, scale, child) {
                    return Transform.scale(scale: scale, child: child);
                  },
                  child: Column(
                    children: [
                      // TODO: Replace with your actual login header asset path.
                      Image.asset(
                        'assets/images/login_header_placeholder.png',
                        height: 110,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.directions_car_filled_rounded,
                          size: 72,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                Text(
                  'Welcome back',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  'Login to continue',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

