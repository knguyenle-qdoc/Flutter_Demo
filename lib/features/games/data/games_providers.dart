import 'package:flutter_application_1/core/api/dio_provider.dart';
import 'package:flutter_application_1/features/games/data/games_api.dart';
import 'package:flutter_application_1/features/games/data/games_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Creates `GamesApi` using the shared Dio client.
///
/// React analogy:
/// - Similar to exporting a singleton service built from shared config.
final gamesApiProvider = Provider<GamesApi>((ref) {
  final dio = ref.watch(dioProvider);
  return GamesApi(dio);
});

/// Creates repository from API.
///
/// React analogy:
/// - Similar to composing dependencies once and consuming via custom hooks.
final gamesRepositoryProvider = Provider<GamesRepository>((ref) {
  final api = ref.watch(gamesApiProvider);
  return GamesRepository(api);
});
