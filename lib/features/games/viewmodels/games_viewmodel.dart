import 'dart:async';

import 'package:flutter_application_1/core/api/response_model.dart';
import 'package:flutter_application_1/features/games/data/games_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/features/games/models/game.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Exposes async games state to the UI.
///
/// React analogy:
/// - Similar to a custom hook (like `useGames`) that returns
///   `{ data, isLoading, error, refetch }`.
final gamesViewModelProvider =
    AsyncNotifierProvider<GamesViewModel, RawgResponse<Game>>(() {
      return GamesViewModel();
    });

final gamesSearchProvider = FutureProvider.family<RawgResponse<Game>, String>((
  ref,
  query,
) async {
  final repo = ref.watch(gamesRepositoryProvider);
  return repo.fetchGames(search: query);
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchCacheTimestampsProvider = StateProvider<Map<String, DateTime>>(
  (ref) => {},
);

const searchCacheDuration = Duration(seconds: 5);

/// Handles fetching + refresh behavior for `GamesScreen`.
class GamesViewModel extends AsyncNotifier<RawgResponse<Game>> {
  @override
  /// Called the first time provider is read.
  /// Riverpod uses this as the initial async load.
  Future<RawgResponse<Game>> build() async {
    final repo = ref.watch(gamesRepositoryProvider);
    return repo.fetchGames();
  }

  /// Manual reload method used by the refresh button.
  Future<void> refresh() async {
    // Immediately show loading in the UI.
    state = const AsyncLoading();

    // Runs fetch and captures errors into AsyncError automatically.
    state = await AsyncValue.guard(() async {
      final repo = ref.read(gamesRepositoryProvider);
      return repo.fetchGames();
    });
  }

  // Search function with timed cache invalidation to prevent excessive API calls.
  Future<void> runSearch(WidgetRef ref, String rawQuery) async {
    final query = rawQuery.trim().toLowerCase();
    if (query.isEmpty) {
      ref.read(searchQueryProvider.notifier).state = '';
      return;
    }

    final cacheMap = ref.read(searchCacheTimestampsProvider);
    final lastFetched = cacheMap[query];
    final now = DateTime.now();

    final isStale =
        lastFetched == null ||
        now.difference(lastFetched) > searchCacheDuration;

    if (isStale) {
      ref.invalidate(gamesSearchProvider(query));
      ref.read(searchCacheTimestampsProvider.notifier).state = {
        ...cacheMap,
        query: now,
      };
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = await ref.read(gamesSearchProvider(query).future);
      return repo;
    });
  }
}
