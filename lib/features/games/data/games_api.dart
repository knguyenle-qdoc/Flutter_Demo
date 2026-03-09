import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/api/response_model.dart';
import 'package:flutter_application_1/features/games/models/game.dart';

/// Low-level API client for games endpoints.
///
/// React analogy:
/// - Similar to a `gamesApi.ts` service file with raw HTTP calls.
class GamesApi {
  final Dio _dio;

  GamesApi(this._dio);

  /// Calls `GET /games` and converts JSON into `RawgResponse<Game>`.
  Future<RawgResponse<Game>> fetchGames({String? search}) async {
    final res = await _dio.get('/games', queryParameters: {'search': ?search});
    return RawgResponse.fromJson(res.data, (json) => Game.fromJson(json));
  }
}
