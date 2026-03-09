import 'package:flutter_application_1/core/api/dio_provider.dart';
import 'package:flutter_application_1/features/product/data/product_api.dart';
import 'package:flutter_application_1/features/product/data/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsApiProvider = Provider<ProductsApi>((ref) {
  final dio = ref.watch(dioProvider);
  return ProductsApi(dio);
});

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final api = ref.watch(productsApiProvider);
  return ProductsRepository(api);
});
