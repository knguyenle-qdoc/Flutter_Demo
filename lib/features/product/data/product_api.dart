import 'package:dio/dio.dart';
import 'package:flutter_application_1/features/games/models/game.dart';

class ProductsApi {
  final Dio _dio;

  ProductsApi(this._dio);

  Future<Game> fetchGameDetails({required int id}) async {
    final res = await _dio.get('/games/$id');
    return Game.fromJson(res.data);
  }
}
