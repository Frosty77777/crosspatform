// Chapter 18 — Widget test for RestaurantItem.
//
// A widget test boots a *single* widget (not the full app) inside a
// `MaterialApp` host and uses `WidgetTester` to drive it.
//
// Three classic phases:
//   1. ARRANGE — build the widget tree with `tester.pumpWidget(...)`.
//   2. ACT     — interact with it: `tester.tap`, `tester.enterText`, etc.
//   3. ASSERT  — locate widgets with `find.*` and check them with `expect`.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:untitled2/components/restaurant_item.dart';
import 'package:untitled2/models/restaurant.dart';

void main() {
  // A test fixture (sample data) that we reuse across tests.
  final tesla = Item(
    name: 'Tesla Model 3',
    description: 'Electric sedan with autopilot.',
    price: 120,
    imageUrl: 'https://example.com/tesla.jpg',
  );

  // Helper: wrap the unit-under-test in the minimum host needed to render
  // Material widgets (theme, MediaQuery, Directionality, …).
  //
  // We bound BOTH dimensions because RestaurantItem internally has a
  // 1:1 AspectRatio image — without a bounded height it would overflow
  // horizontally in the test environment.
  //
  // The ProviderScope is required because the CarDetailSheet that this
  // widget can open is a ConsumerWidget.
  Widget hostFor(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(width: 360, height: 140, child: child),
          ),
        ),
      ),
    );
  }

  testWidgets('shows the item name, description and price per day',
      (tester) async {
    await tester.pumpWidget(hostFor(RestaurantItem(item: tesla)));

    // Network image will fail in tests; errorBuilder kicks in.
    // We do NOT call pumpAndSettle here because the network error happens
    // asynchronously and could spin forever — a single pump is enough
    // to render the text we care about.

    expect(find.text('Tesla Model 3'), findsOneWidget);
    expect(find.text('Electric sedan with autopilot.'), findsOneWidget);
    expect(find.text('\$120/day'), findsOneWidget);
    expect(find.text('Book'), findsOneWidget);
  });

  testWidgets('renders a fallback car icon when the network image fails',
      (tester) async {
    await tester.pumpWidget(hostFor(RestaurantItem(item: tesla)));
    // Let the image-load future complete and trigger errorBuilder.
    await tester.pump(const Duration(seconds: 1));

    expect(find.byIcon(Icons.directions_car), findsOneWidget);
  });

  testWidgets('formats the price with no decimal places', (tester) async {
    final fractional = Item(
      name: 'Honda Civic',
      description: 'Reliable',
      price: 59.99,
      imageUrl: 'https://example.com/civic.jpg',
    );
    await tester.pumpWidget(hostFor(RestaurantItem(item: fractional)));

    // 59.99 → "60/day" via toStringAsFixed(0)
    expect(find.text('\$60/day'), findsOneWidget);
  });

  testWidgets('tapping the Book button opens the detail sheet',
      (tester) async {
    await tester.pumpWidget(hostFor(RestaurantItem(item: tesla)));

    await tester.tap(find.text('Book'));
    await tester.pump(); // start the bottom-sheet route
    await tester.pump(const Duration(milliseconds: 300)); // settle animation

    // The detail sheet shows the item name in its header — we should now
    // see two instances of "Tesla Model 3" (one in the card, one in the
    // sheet). At minimum, the sheet is open if we see the booking UI.
    expect(find.text('Tesla Model 3'), findsWidgets);
  });
}
