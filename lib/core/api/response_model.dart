/// Generic RAWG paginated response container.
///
/// React analogy:
/// - Similar to defining a TypeScript interface like:
///   `ApiPage<T> = { count: number; next?: string; previous?: string; results: T[] }`
class RawgResponse<T> {
  final int count;
  final String? next;
  final String? previous;
  final List<T> results;

  RawgResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory RawgResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    // `fromJsonT` lets callers decide how each `results` item is converted.
    return RawgResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
