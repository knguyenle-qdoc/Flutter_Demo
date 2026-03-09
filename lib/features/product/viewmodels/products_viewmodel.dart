import 'package:flutter_application_1/features/games/models/game.dart';
import 'package:flutter_application_1/features/product/data/product_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsViewModelProvider = FutureProvider.family<Game, int>((
  ref,
  id,
) async {
  final repo = ref.watch(productsRepositoryProvider);
  return repo.fetchGameDetails(id: id);
});
