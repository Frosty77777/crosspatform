import 'package:flutter/material.dart';

import '../state/app_state_scope.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AppStateScope.of(context).user;
    final cs = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: user,
      builder: (context, _) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 16),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: cs.primaryContainer,
                  child: Icon(Icons.person, size: 40, color: cs.primary),
                ),
                const SizedBox(height: 12),
                Text(
                  user.username.isEmpty ? 'User' : user.username,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () => user.logout(),
            ),
          ),
        ],
      ),
    );
  }
}

