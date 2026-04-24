import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _favoritesKey = 'favorite_car_ids';

class FavoritesNotifier extends AsyncNotifier<Set<String>> {
  @override
  Future<Set<String>> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey)?.toSet() ?? <String>{};
  }

  Future<void> toggleFavorite(String carId) async {
    final current = state.value ?? <String>{};
    final next = Set<String>.from(current);
    if (!next.add(carId)) {
      next.remove(carId);
    }
    state = AsyncData(next);
    await _persist(next);
  }

  Future<void> removeFavorite(String carId) async {
    final current = state.value ?? <String>{};
    if (!current.contains(carId)) return;
    final next = Set<String>.from(current)..remove(carId);
    state = AsyncData(next);
    await _persist(next);
  }

  Future<void> _persist(Set<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, ids.toList(growable: false));
  }
}

final favoritesProvider =
    AsyncNotifierProvider<FavoritesNotifier, Set<String>>(FavoritesNotifier.new);
