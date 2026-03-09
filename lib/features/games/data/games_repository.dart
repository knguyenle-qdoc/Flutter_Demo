import 'package:flutter_application_1/features/games/data/games_api.dart';
import 'package:flutter_application_1/core/api/response_model.dart';
import 'package:flutter_application_1/features/games/models/game.dart';

/// Repository layer between viewmodels and API services.
///
/// Why this exists:
/// - Central place for data rules, caching, mapping, combining APIs, etc.
///
/// React analogy:
/// - Similar to a domain data module used by hooks like `useGamesQuery`.
class GamesRepository {
  final GamesApi _api;

  GamesRepository(this._api);

  /// Fetches games from the API.
  /// Keep this method even if it currently forwards 1:1; it gives you
  /// a stable seam for future business logic.
  Future<RawgResponse<Game>> fetchGames({String? search}) async {
    return _api.fetchGames(search: search);
  }
}
