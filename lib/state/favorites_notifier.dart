import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/persistence_providers.dart';

class FavoritesNotifier extends AsyncNotifier<Set<String>> {
  @override
  Future<Set<String>> build() async {
    final repo = ref.read(localDataRepositoryProvider);
    return repo.loadFavorites();
  }

  Future<void> toggleFavorite(String carId) async {
    final repo = ref.read(localDataRepositoryProvider);
    final current = state.value ?? <String>{};
    final next = Set<String>.from(current);
    final added = next.add(carId);
    if (!added) {
      next.remove(carId);
    }
    state = AsyncData(next);
    await repo.setFavorite(carId, isFavorite: added);
  }

  Future<void> removeFavorite(String carId) async {
    final repo = ref.read(localDataRepositoryProvider);
    final current = state.value ?? <String>{};
    if (!current.contains(carId)) return;
    final next = Set<String>.from(current)..remove(carId);
    state = AsyncData(next);
    await repo.setFavorite(carId, isFavorite: false);
  }
}

final favoritesProvider =
    AsyncNotifierProvider<FavoritesNotifier, Set<String>>(FavoritesNotifier.new);
