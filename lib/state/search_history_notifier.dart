import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _searchHistoryKey = 'car_search_history';
const _maxSearchItems = 12;

class SearchHistoryNotifier extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_searchHistoryKey) ?? <String>[];
  }

  Future<void> addSearch(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    final current = state.value ?? <String>[];
    final withoutDuplicate = current
        .where((value) => value.toLowerCase() != trimmed.toLowerCase())
        .toList(growable: true);
    withoutDuplicate.insert(0, trimmed);
    final next = withoutDuplicate.take(_maxSearchItems).toList(growable: false);
    state = AsyncData(next);
    await _persist(next);
  }

  Future<void> removeSearch(String query) async {
    final current = state.value ?? <String>[];
    final next = current
        .where((value) => value.toLowerCase() != query.toLowerCase())
        .toList(growable: false);
    state = AsyncData(next);
    await _persist(next);
  }

  Future<void> _persist(List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_searchHistoryKey, values);
  }
}

final searchHistoryProvider = AsyncNotifierProvider<SearchHistoryNotifier, List<String>>(
  SearchHistoryNotifier.new,
);
