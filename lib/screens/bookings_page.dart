import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ── Bookings Page ────────────────────────────────────────────────────────────
class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('My Bookings',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          ..._demoBookings.map(
            (b) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(Icons.directions_car,
                      color: Theme.of(context).colorScheme.primary),
                ),
                title: Text(b['car']!),
                subtitle: Text('${b['provider']} · ${b['date']}'),
                trailing: Chip(
                  label: Text(b['status']!),
                  labelStyle: TextStyle(
                    fontSize: 11,
                    color: b['status'] == 'Active'
                        ? Colors.green.shade800
                        : Colors.grey.shade700,
                  ),
                  backgroundColor: b['status'] == 'Active'
                      ? Colors.green.shade100
                      : Colors.grey.shade200,
                  padding: EdgeInsets.zero,
                ),
                onTap: () => context.go('/restaurant/${b['restaurantId']}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _demoBookings = [
  {'car': 'Tesla Model 3', 'provider': 'cashauto rent', 'date': 'Apr 12', 'status': 'Active', 'restaurantId': '0'},
  {'car': 'Honda Civic',   'provider': 'Urban Auto',    'date': 'Apr 18', 'status': 'Upcoming', 'restaurantId': '1'},
  {'car': 'BMW X5',        'provider': 'cashauto rent', 'date': 'Apr 25', 'status': 'Upcoming', 'restaurantId': '0'},
];

// ── Account Page ─────────────────────────────────────────────────────────────
class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(children: [
              const SizedBox(height: 16),
              CircleAvatar(
                radius: 40,
                backgroundColor: cs.primaryContainer,
                child: Icon(Icons.person, size: 40, color: cs.primary),
              ),
              const SizedBox(height: 12),
              Text('Alex Renter',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700)),
              Text('alex@example.com',
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 24),
            ]),
          ),
          ..._menuItems.map(
            (item) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Icon(item['icon'] as IconData),
                title: Text(item['title'] as String),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _menuItems = [
  {'icon': Icons.credit_card_outlined,  'title': 'Payment methods'},
  {'icon': Icons.history_outlined,      'title': 'Rental history'},
  {'icon': Icons.favorite_border,       'title': 'Saved cars'},
  {'icon': Icons.notifications_outlined,'title': 'Notifications'},
  {'icon': Icons.help_outline,          'title': 'Help & support'},
  {'icon': Icons.logout,                'title': 'Sign out'},
];
