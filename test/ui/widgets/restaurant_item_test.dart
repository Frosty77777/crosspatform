// Widget + golden tests for `RestaurantItem`.
//
// Part 3 — Widget tests use `tester.pumpWidget`, `find.*`, `expect`.
// Part 4 — Golden tests use `golden_toolkit`'s `testGoldens`,
//          `GoldenBuilder.grid`, `pumpWidgetBuilder`, `materialAppWrapper`
//          and `screenMatchesGolden`.
//
// All test bodies follow Arrange / Act / Assert.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'package:untitled2/components/restaurant_item.dart';
import 'package:untitled2/models/restaurant.dart';

void main() {
  // Reusable test fixtures (kept const where possible).
  final tesla = Item(
    name: 'Tesla Model 3',
    description: 'Electric sedan with autopilot.',
    price: 120,
    imageUrl: 'https://example.com/tesla.jpg',
  );
  final corolla = Item(
    name: 'Toyota Corolla',
    description: 'Compact city car — great fuel economy.',
    price: 55,
    imageUrl: 'https://example.com/corolla.jpg',
  );
  final bmwX5 = Item(
    name: 'BMW X5',
    description:
        'A spacious luxury SUV with strong performance and a refined interior.',
    price: 145,
    imageUrl: 'https://example.com/bmwx5.jpg',
  );
  final cheap = Item(
    name: 'Hyundai Accent',
    description: 'Budget pick.',
    price: 35,
    imageUrl: 'https://example.com/accent.jpg',
  );

  // Host wrapper for non-golden widget tests.  RestaurantItem internally
  // has a 1:1 AspectRatio image, so the host bounds both dimensions to
  // prevent layout overflow in the test environment. The ProviderScope
  // is required because tapping "Book" opens a Riverpod ConsumerWidget.
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

  group('RestaurantItem', () {
    testWidgets('shows the item name, description and price per day',
        (tester) async {
      // Arrange
      await tester.pumpWidget(hostFor(RestaurantItem(item: tesla)));

      // Act — a single frame is enough; network image fails async via
      // the widget's errorBuilder, but the surrounding text is already
      // laid out.

      // Assert
      expect(find.text('Tesla Model 3'), findsOneWidget);
      expect(find.text('Electric sedan with autopilot.'), findsOneWidget);
      expect(find.text('\$120/day'), findsOneWidget);
      expect(find.text('Book'), findsOneWidget);
    });

    testWidgets(
      'renders a fallback car icon when the network image fails',
      (tester) async {
        // Arrange
        await tester.pumpWidget(hostFor(RestaurantItem(item: tesla)));

        // Act — give the image future time to complete and the
        // errorBuilder to run.
        await tester.pump(const Duration(seconds: 1));

        // Assert
        expect(find.byIcon(Icons.directions_car), findsOneWidget);
      },
    );

    testWidgets('formats the price with no decimal places', (tester) async {
      // Arrange
      final fractional = Item(
        name: 'Honda Civic',
        description: 'Reliable',
        price: 59.99,
        imageUrl: 'https://example.com/civic.jpg',
      );

      // Act
      await tester.pumpWidget(hostFor(RestaurantItem(item: fractional)));

      // Assert — 59.99 → "$60/day" via toStringAsFixed(0).
      expect(find.text('\$60/day'), findsOneWidget);
    });

    testWidgets('tapping the Book button opens the detail sheet',
        (tester) async {
      // Arrange
      await tester.pumpWidget(hostFor(RestaurantItem(item: tesla)));

      // Act
      await tester.tap(find.text('Book'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Assert — the item name now appears twice: once in the card and
      // once in the opened detail sheet header.
      expect(find.text('Tesla Model 3'), findsNWidgets(2));
    });
  });

  // ─────────────────────────────────────────────────────────────────────
  // Part 4 — Golden (visual regression) tests.
  //
  // Each golden snapshots a 2x2 grid of meaningful visual variants of
  // RestaurantItem under both light and dark themes. Run once with
  //   flutter test --update-goldens
  // to (re)generate the baseline PNGs under goldens/.
  // ─────────────────────────────────────────────────────────────────────
  group('Golden Tests - RestaurantItem', () {
    Widget buildItem(Item item) {
      return SizedBox(width: 360, height: 140, child: RestaurantItem(item: item));
    }

    testGoldens('can support light theme', (tester) async {
      // Arrange
      final builder = GoldenBuilder.grid(columns: 2, widthToHeightRatio: 1)
        ..addScenario('Light - Premium', buildItem(tesla))
        ..addScenario('Light - Compact', buildItem(corolla))
        ..addScenario('Light - Long description', buildItem(bmwX5))
        ..addScenario('Light - Budget', buildItem(cheap));

      // Act
      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(theme: ThemeData.light()),
      );

      // Assert
      await screenMatchesGolden(tester, 'light_restaurant_item');
    });

    testGoldens('can support dark theme', (tester) async {
      // Arrange
      final builder = GoldenBuilder.grid(columns: 2, widthToHeightRatio: 1)
        ..addScenario('Dark - Premium', buildItem(tesla))
        ..addScenario('Dark - Compact', buildItem(corolla))
        ..addScenario('Dark - Long description', buildItem(bmwX5))
        ..addScenario('Dark - Budget', buildItem(cheap));

      // Act
      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(theme: ThemeData.dark()),
      );

      // Assert
      await screenMatchesGolden(tester, 'dark_restaurant_item');
    });
  });
}
