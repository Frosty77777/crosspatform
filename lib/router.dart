import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/explore_page.dart';
import '../screens/bookings_page.dart';
import '../screens/restaurant_page.dart';
import '../screens/chapter7_widgets_page.dart';
import '../models/restaurant.dart';

/// Chapter 8 — go_router configuration
///
/// ShellRoute keeps the bottom NavigationBar alive during sub-navigation.
/// The 'redirect' callback is a stub — replace with your real auth check.

final appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,

  // ── auth guard (stub) ────────────────────────────────────────────────────
  redirect: (context, state) {
    // Replace with real auth: if (!AuthService.isLoggedIn) return '/login';
    return null;
  },

  routes: [
    // ── Shell keeps BottomNavigationBar / Drawer alive ────────────────────
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          name: 'explore',
          builder: (context, state) => ExplorePage(),
        ),
        GoRoute(
          path: '/bookings',
          name: 'bookings',
          builder: (context, state) => const BookingsPage(),
        ),
        GoRoute(
          path: '/account',
          name: 'account',
          builder: (context, state) => const AccountPage(),
        ),
        GoRoute(
          path: '/widgets-demo',
          name: 'widgets-demo',
          builder: (_, __) => const Chapter7WidgetsPage(),
        ),
      ],
    ),

    // ── Full-screen routes (no shell / no bottom bar) ────────────────────
    GoRoute(
      path: '/restaurant/:id',
      name: 'restaurant',
      builder: (_, state) {
        final id = state.pathParameters['id']!;
        final restaurant = restaurants.firstWhere(
          (r) => r.id == id,
          orElse: () => restaurants.first,
        );
        return RestaurantPage(restaurant: restaurant);
      },
    ),
  ],
);

// ── AppShell ────────────────────────────────────────────────────────────────
/// Wraps the ShellRoute child with a Scaffold that has both a
/// NavigationDrawer (hamburger) and a bottom NavigationBar.

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  // Map each tab path to a numeric index
  static const _tabs = ['/', '/bookings', '/account'];

  int _locationToIndex(String location) {
    final idx = _tabs.indexWhere((t) => location.startsWith(t));
    return idx < 0 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToIndex(location);

    return Scaffold(
      // ── AppBar ──────────────────────────────────────────────────────────
      appBar: AppBar(
        title: const Text(
          'Car Rent',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        // Hamburger opens the drawer
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.widgets_outlined),
            tooltip: 'Ch.7 Widget Demo',
            onPressed: () => context.go('/widgets-demo'),
          ),
          const SizedBox(width: 8),
        ],
      ),

      // ── Navigation Drawer (sidebar) ─────────────────────────────────────
      drawer: NavigationDrawer(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          context.go(_tabs[index]);
          Navigator.pop(context); // close drawer
        },
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 24, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(Icons.directions_car,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(height: 12),
                Text('Car Rent',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        )),
                Text('Find your perfect ride',
                    style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ),
          const Divider(),
          const NavigationDrawerDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: Text('Explore'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.list_outlined),
            selectedIcon: Icon(Icons.list),
            label: Text('Bookings'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.person_2_outlined),
            selectedIcon: Icon(Icons.person),
            label: Text('Account'),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 4),
            child: Text('More',
                style: Theme.of(context).textTheme.labelSmall),
          ),
          ListTile(
            leading: const Icon(Icons.widgets_outlined),
            title: const Text('Widget Demo'),
            onTap: () {
              Navigator.pop(context);
              context.go('/widgets-demo');
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 28),
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () => Navigator.pop(context),
            contentPadding: const EdgeInsets.symmetric(horizontal: 28),
          ),
        ],
      ),

      // ── Body (injected by ShellRoute) ───────────────────────────────────
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: child,
      ),

      // ── Bottom NavigationBar ────────────────────────────────────────────
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) => context.go(_tabs[index]),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Explore',
              ),
              NavigationDestination(
                icon: Icon(Icons.list_outlined),
                selectedIcon: Icon(Icons.list),
                label: 'Bookings',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_2_outlined),
                selectedIcon: Icon(Icons.person),
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
