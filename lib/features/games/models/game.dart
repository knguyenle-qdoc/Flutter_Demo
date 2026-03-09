/// Game model modeled after the results of `RawgResponse<Game>`.
///
/// React analogy:
/// - Similar to a TypeScript `type Game = { ... }` used across components.
class Game {
  final int? id;
  final String? slug;
  final String? name;
  final String? released;
  final bool? tba;
  final String? backgroundImage;
  final double rating;
  final int? ratingTop;
  final List<GameRating> ratings;
  final int? ratingsCount;
  final int? reviewsTextCount;
  final int? added;
  final AddedByStatus? addedByStatus;
  final int? metacritic;
  final int? playtime;
  final int? suggestionsCount;
  final String? updated;
  final EsrbRating? esrbRating;
  final List<GamePlatform> platforms;
  final String? descriptionRaw;
  final String? dominantColor;
  final String? saturatedColor;
  final List<Developer> developers;
  final List<Publisher> publishers;
  final List<Genre> genres;

  const Game({
    this.id,
    this.slug,
    this.name,
    this.released,
    this.tba,
    this.backgroundImage,
    required this.rating,
    this.ratingTop,
    this.ratings = const [],
    this.ratingsCount,
    this.reviewsTextCount,
    this.added,
    this.addedByStatus,
    this.metacritic,
    this.playtime,
    this.suggestionsCount,
    this.updated,
    this.esrbRating,
    this.platforms = const [],
    this.descriptionRaw,
    this.dominantColor,
    this.saturatedColor,
    this.developers = const [],
    this.publishers = const [],
    this.genres = const [],
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'slug': slug,
    'name': name,
    'released': released,
    'tba': tba,
    'background_image': backgroundImage,
    'rating': rating,
    'rating_top': ratingTop,
    'ratings': ratings.map((r) => r.toJson()).toList(),
    'ratings_count': ratingsCount,
    'reviews_text_count': reviewsTextCount,
    'added': added,
    'added_by_status': addedByStatus?.toJson(),
    'metacritic': metacritic,
    'playtime': playtime,
    'suggestions_count': suggestionsCount,
    'updated': updated,
    'esrb_rating': esrbRating?.toJson(),
    'platforms': platforms.map((p) => p.toJson()).toList(),
    'description_raw': descriptionRaw,
    'dominant_color': dominantColor,
    'saturated_color': saturatedColor,
    'developers': developers.map((d) => d.toJson()).toList(),
    'publishers': publishers.map((p) => p.toJson()).toList(),
    'genres': genres.map((g) => g.toJson()).toList(),
  };

  /// Converts RAWG JSON into a strongly-typed `Game`.
  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      released: json['released'],
      tba: json['tba'],
      backgroundImage: json['background_image'],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      ratingTop: json['rating_top'],
      ratings: (json['ratings'] as List<dynamic>? ?? [])
          .map((rating) => GameRating.fromJson(rating as Map<String, dynamic>))
          .toList(),
      ratingsCount: json['ratings_count'],
      reviewsTextCount: json['reviews_text_count'],
      added: json['added'],
      addedByStatus: json['added_by_status'] == null
          ? null
          : AddedByStatus.fromJson(
              json['added_by_status'] as Map<String, dynamic>,
            ),
      metacritic: json['metacritic'],
      playtime: json['playtime'],
      suggestionsCount: json['suggestions_count'],
      updated: json['updated'],
      esrbRating: json['esrb_rating'] == null
          ? null
          : EsrbRating.fromJson(json['esrb_rating'] as Map<String, dynamic>),
      platforms:
          (json['platforms'] as List<dynamic>?)
              ?.map(
                (platform) =>
                    GamePlatform.fromJson(platform as Map<String, dynamic>),
              )
              .toList() ??
          [],
      descriptionRaw: json['description_raw'],
      dominantColor: json['dominant_color'],
      saturatedColor: json['saturated_color'],
      developers:
          (json['developers'] as List<dynamic>?)
              ?.map(
                (developer) =>
                    Developer.fromJson(developer as Map<String, dynamic>),
              )
              .toList() ??
          [],
      publishers:
          (json['publishers'] as List<dynamic>?)
              ?.map(
                (publisher) =>
                    Publisher.fromJson(publisher as Map<String, dynamic>),
              )
              .toList() ??
          [],
      genres:
          (json['genres'] as List<dynamic>?)
              ?.map((genre) => Genre.fromJson(genre as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

/// Breakdown item for the `ratings` array.
class GameRating {
  final int? id;
  final String? title;
  final int? count;
  final double? percent;

  const GameRating({this.id, this.title, this.count, this.percent});

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'count': count,
    'percent': percent,
  };

  /// Parses one rating object from JSON.
  factory GameRating.fromJson(Map<String, dynamic> json) {
    return GameRating(
      id: json['id'],
      title: json['title'],
      count: json['count'],
      percent: (json['percent'] as num?)?.toDouble(),
    );
  }
}

/// Counts for how users added the game in their libraries.
class AddedByStatus {
  final int? yet;
  final int? owned;
  final int? beaten;
  final int? toplay;
  final int? dropped;
  final int? playing;

  const AddedByStatus({
    this.yet,
    this.owned,
    this.beaten,
    this.toplay,
    this.dropped,
    this.playing,
  });

  Map<String, dynamic> toJson() => {
    'yet': yet,
    'owned': owned,
    'beaten': beaten,
    'toplay': toplay,
    'dropped': dropped,
    'playing': playing,
  };

  /// Parses `added_by_status` object from JSON.
  factory AddedByStatus.fromJson(Map<String, dynamic> json) {
    return AddedByStatus(
      yet: json['yet'],
      owned: json['owned'],
      beaten: json['beaten'],
      toplay: json['toplay'],
      dropped: json['dropped'],
      playing: json['playing'],
    );
  }
}

/// ESRB metadata attached to the game.
class EsrbRating {
  final int? id;
  final String? name;
  final String? slug;

  const EsrbRating({this.id, this.name, this.slug});

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'slug': slug};

  /// Parses `esrb_rating` object from JSON.
  factory EsrbRating.fromJson(Map<String, dynamic> json) {
    return EsrbRating(id: json['id'], name: json['name'], slug: json['slug']);
  }
}

/// Platform wrapper in RAWG response (`platforms` array item).
class GamePlatform {
  final PlatformInfo? platform;
  final String? releasedAt;
  final Map<String, dynamic>? requirementsEn;
  final Map<String, dynamic>? requirementsRu;

  const GamePlatform({
    this.platform,
    this.releasedAt,
    this.requirementsEn,
    this.requirementsRu,
  });

  Map<String, dynamic> toJson() => {
    'platform': platform?.toJson(),
    'released_at': releasedAt,
    'requirements_en': requirementsEn,
    'requirements_ru': requirementsRu,
  };

  /// Parses one platform entry, including optional requirements.
  factory GamePlatform.fromJson(Map<String, dynamic> json) {
    return GamePlatform(
      platform: json['platform'] == null
          ? null
          : PlatformInfo.fromJson(json['platform'] as Map<String, dynamic>),
      releasedAt: json['released_at'],
      requirementsEn: json['requirements_en'] as Map<String, dynamic>?,
      requirementsRu: json['requirements_ru'] as Map<String, dynamic>?,
    );
  }
}

/// Platform metadata nested inside each `GamePlatform`.
class PlatformInfo {
  final int? id;
  final String? name;
  final String? slug;
  final String? image;
  final int? yearEnd;
  final int? yearStart;
  final int? gamesCount;
  final String? imageBackground;

  const PlatformInfo({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.yearEnd,
    this.yearStart,
    this.gamesCount,
    this.imageBackground,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'image': image,
    'year_end': yearEnd,
    'year_start': yearStart,
    'games_count': gamesCount,
    'image_background': imageBackground,
  };

  /// Parses platform details from JSON.
  factory PlatformInfo.fromJson(Map<String, dynamic> json) {
    return PlatformInfo(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
      yearEnd: json['year_end'],
      yearStart: json['year_start'],
      gamesCount: json['games_count'],
      imageBackground: json['image_background'],
    );
  }
}

class Developer {
  final int? id;
  final String? name;
  final String? imageBackground;

  const Developer({this.id, this.name, this.imageBackground});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image_background': imageBackground,
  };

  factory Developer.fromJson(Map<String, dynamic> json) {
    return Developer(
      id: json['id'],
      name: json['name'],
      imageBackground: json['image_background'],
    );
  }
}

class Genre {
  final int? id;
  final String? name;
  final String? imageBackground;

  const Genre({this.id, this.name, this.imageBackground});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image_background': imageBackground,
  };

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
      imageBackground: json['image_background'],
    );
  }
}

class Publisher {
  final int? id;
  final String? name;
  final String? imageBackground;

  const Publisher({this.id, this.name, this.imageBackground});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image_background': imageBackground,
  };

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(
      id: json['id'],
      name: json['name'],
      imageBackground: json['image_background'],
    );
  }
}
