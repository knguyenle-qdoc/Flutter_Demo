import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shared HTTP client configuration for the app.
///
/// React analogy:
/// - Comparable to creating a preconfigured Axios instance in one module
///   and importing it everywhere.
final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      // Base URL from .env to keep secrets/config out of source code.
      baseUrl: dotenv.env['API_RAWG_BASE_URL']!,
      // Add 'search' as an optional query param. To use, pass it in request options.
      queryParameters: {'key': dotenv.env['API_RAWG_KEY']!},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  // To add 'search', use: dio.get('/games', queryParameters: {'search': searchTerm})
});
