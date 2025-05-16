class NearbySearchResponse {
  final String? nextPageToken;
  final List<FoodPlace> results;

  NearbySearchResponse({
    required this.nextPageToken,
    required this.results,
  });

  factory NearbySearchResponse.fromJson(Map<String, dynamic> json) {
    return NearbySearchResponse(
      nextPageToken: json['next_page_token'],
      results: (json['results'] as List<dynamic>)
          .map((item) => FoodPlace.fromJson(item))
          .toList(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'next_page_token': nextPageToken,
      'results': results.map((place) => place.toJson()).toList(),
    };
  }
}

class FoodPlace {
  final String placeId;
  final String name;
  final double lat;
  final double lng;
  final bool isOpen;
  final List<String> photoReferences;
  final double rating;
  final int userRatingsTotal;
  final String vicinity;

  FoodPlace({
    required this.placeId,
    required this.name,
    required this.lat,
    required this.lng,
    required this.isOpen,
    required this.photoReferences,
    required this.rating,
    required this.userRatingsTotal,
    required this.vicinity,
  });

  factory FoodPlace.fromJson(Map<String, dynamic> json) {
    final location = json['geometry']['location'];
    final photos = json['photos'] as List<dynamic>?;

    return FoodPlace(
      placeId: json['place_id'],
      name: json['name'],
      lat: location['lat'],
      lng: location['lng'],
      isOpen: json['opening_hours']?['open_now'] ?? false,
      photoReferences: photos?.map((p) => p['photo_reference'] as String).toList() ?? [],
      rating: (json['rating'] ?? 0).toDouble(),
      userRatingsTotal: json['user_ratings_total'] ?? 0,
      vicinity: json['vicinity'] ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'place_id': placeId,
      'name': name,
      'location': {'lat': lat, 'lng': lng},
      'is_open': isOpen,
      'photo_references': photoReferences,
      'rating': rating,
      'user_ratings_total': userRatingsTotal,
      'vicinity': vicinity,
    };
  }
}
