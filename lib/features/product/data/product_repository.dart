import 'package:flutter_application_1/features/games/models/game.dart';
import 'package:flutter_application_1/features/product/data/product_api.dart';

class ProductsRepository {
  final ProductsApi _api;

  ProductsRepository(this._api);

  Future<Game> fetchGameDetails({required int id}) async {
    return _api.fetchGameDetails(id: id);
  }
}
