import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:untitled2/components/restaurant_section.dart';
import 'package:untitled2/models/restaurant.dart';
import 'package:untitled2/state/favorites_notifier.dart';
import 'package:untitled2/state/search_history_notifier.dart';

import '../../helpers/fake_network_images.dart';

class _FakeFavoritesNotifier extends FavoritesNotifier {
  @override
  Future<Set<String>> build() async => <String>{};
}

void main() {
  // ─── Search history deduplication (unit) ────────────────────────────
  group('SearchHistoryNotifier — deduplication', () {
    setUp(() => SharedPreferences.setMockInitialValues({}));

    test('adding "BMW" twice stores only one entry', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(searchHistoryProvider.future);

      await container.read(searchHistoryProvider.notifier).addSearch('BMW');
      await container.read(searchHistoryProvider.notifier).addSearch('BMW');

      final history = container.read(searchHistoryProvider).value!;
      expect(history.where((e) => e == 'BMW').length, 1);
      expect(history.length, 1);
    });

    test('case-insensitive: "bmw" then "BMW" keeps only the latest', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(searchHistoryProvider.future);

      await container.read(searchHistoryProvider.notifier).addSearch('bmw');
      await container.read(searchHistoryProvider.notifier).addSearch('BMW');

      final history = container.read(searchHistoryProvider).value!;
      expect(history.length, 1);
      expect(history.first, 'BMW');
    });

    test('different queries are stored separately', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(searchHistoryProvider.future);

      await container.read(searchHistoryProvider.notifier).addSearch('BMW');
      await container.read(searchHistoryProvider.notifier).addSearch('Toyota');

      final history = container.read(searchHistoryProvider).value!;
      expect(history.length, 2);
      expect(history, ['Toyota', 'BMW']);
    });

    test('adding same query three times still stores it once', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await container.read(searchHistoryProvider.future);

      await container.read(searchHistoryProvider.notifier).addSearch('BMW');
      await container.read(searchHistoryProvider.notifier).addSearch('BMW');
      await container.read(searchHistoryProvider.notifier).addSearch('BMW');

      final history = container.read(searchHistoryProvider).value!;
      expect(history.length, 1);
    });
  });

  // ─── Widget test: search filtering in RestaurantSection ─────────────
  group('RestaurantSection — search filtering', () {
    final testRestaurants = [
      Restaurant(
        '1',
        'BMW Dealer',
        'Main Street 1',
        'Luxury cars, BMW models',
        'https://example.com/bmw.jpg',
        1.0,
        4.5,
        [
          Item(
            name: 'BMW X5',
            description: 'Luxury SUV',
            price: 145,
            imageUrl: 'https://example.com/x5.jpg',
          ),
        ],
        [],
      ),
      Restaurant(
        '2',
        'Toyota Center',
        'Second Avenue 5',
        'Family cars, sedans',
        'https://example.com/toyota.jpg',
        2.0,
        4.0,
        [
          Item(
            name: 'Toyota Camry',
            description: 'Reliable sedan',
            price: 60,
            imageUrl: 'https://example.com/camry.jpg',
          ),
        ],
        [],
      ),
      Restaurant(
        '3',
        'Honda Place',
        'Third Road 10',
        'Compact, efficient',
        'https://example.com/honda.jpg',
        3.0,
        4.2,
        [
          Item(
            name: 'Honda Civic',
            description: 'Compact city car',
            price: 55,
            imageUrl: 'https://example.com/civic.jpg',
          ),
        ],
        [],
      ),
    ];

    setUp(() => SharedPreferences.setMockInitialValues({}));

    Widget buildTestWidget() {
      return ProviderScope(
        overrides: [
          favoritesProvider.overrideWith(() => _FakeFavoritesNotifier()),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: RestaurantSection(restaurants: testRestaurants),
            ),
          ),
        ),
      );
    }

    testWidgets('typing "BMW" filters to only matching restaurants',
        (tester) async {
      installFakeNetworkImages();
      try {
        await tester.pumpWidget(buildTestWidget());
        await tester.pumpAndSettle();

        expect(find.text('BMW Dealer'), findsOneWidget);
        expect(find.text('Toyota Center'), findsOneWidget);
        expect(find.text('Honda Place'), findsOneWidget);

        await tester.enterText(find.byType(TextField), 'BMW');
        await tester.pumpAndSettle();

        expect(find.text('BMW Dealer'), findsOneWidget);
        expect(find.text('Toyota Center'), findsNothing);
        expect(find.text('Honda Place'), findsNothing);
      } finally {
        uninstallFakeNetworkImages();
      }
    });

    testWidgets(
        'typing "BMW", clearing, then typing "BMW" again still shows it once',
        (tester) async {
      installFakeNetworkImages();
      try {
        await tester.pumpWidget(buildTestWidget());
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), 'BMW');
        await tester.pumpAndSettle();
        expect(find.text('BMW Dealer'), findsOneWidget);

        await tester.enterText(find.byType(TextField), '');
        await tester.pumpAndSettle();
        expect(find.text('BMW Dealer'), findsOneWidget);
        expect(find.text('Toyota Center'), findsOneWidget);

        await tester.enterText(find.byType(TextField), 'BMW');
        await tester.pumpAndSettle();
        expect(find.text('BMW Dealer'), findsOneWidget);
        expect(find.text('Toyota Center'), findsNothing);
      } finally {
        uninstallFakeNetworkImages();
      }
    });

    testWidgets('shows "No cars found" when query matches nothing',
        (tester) async {
      installFakeNetworkImages();
      try {
        await tester.pumpWidget(buildTestWidget());
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), 'Lamborghini');
        await tester.pumpAndSettle();

        expect(find.text('No cars found'), findsOneWidget);
      } finally {
        uninstallFakeNetworkImages();
      }
    });

    testWidgets('search is case-insensitive', (tester) async {
      installFakeNetworkImages();
      try {
        await tester.pumpWidget(buildTestWidget());
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField), 'bmw');
        await tester.pumpAndSettle();

        expect(find.text('BMW Dealer'), findsOneWidget);
        expect(find.text('Toyota Center'), findsNothing);
      } finally {
        uninstallFakeNetworkImages();
      }
    });
  });
}
