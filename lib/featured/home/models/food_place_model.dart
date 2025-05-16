// models/food_place_model.dart

class FoodPlacesResponse {
  final List<FoodPlace> results;

  FoodPlacesResponse({required this.results});

  factory FoodPlacesResponse.fromJson(Map<String, dynamic> json) {
    return FoodPlacesResponse(
      results: (json['results'] as List<dynamic>)
          .map((e) => FoodPlace.fromJson(e))
          .toList(),
    );
  }
}

class FoodPlace {
  final String placeId;
  final String image;
  final String name;
  final double rating;
  final String cuisine;
  final String address;
  final String contact;
  final bool isOpen;
  final String priceRange;
  final int waitTime;
  final List<String> peakHours;
  final List<String> features;
  final List<String> dietary;
  final Location location;
  final OpeningHours openingHours;
  final PopularItems popularItems;
  final ReviewInsights reviewInsights;
  final Engagement engagement;
  final UserReviews userReviews;

  FoodPlace({
    required this.placeId,
    required this.image,
    required this.name,
    required this.rating,
    required this.cuisine,
    required this.address,
    required this.contact,
    required this.isOpen,
    required this.priceRange,
    required this.waitTime,
    required this.peakHours,
    required this.features,
    required this.dietary,
    required this.location,
    required this.openingHours,
    required this.popularItems,
    required this.reviewInsights,
    required this.engagement,
    required this.userReviews,
  });

  factory FoodPlace.fromJson(Map<String, dynamic> json) {
    return FoodPlace(
      placeId: json['placeId'],
      image: json['image'],
      name: json['name'],
      rating: (json['rating'] as num).toDouble(),
      cuisine: json['cuisine'],
      address: json['address'],
      contact: json['contact'],
      isOpen: json['isOpen'],
      priceRange: json['priceRange'],
      waitTime: json['waitTime'],
      peakHours: List<String>.from(json['peakHours']),
      features: List<String>.from(json['features']),
      dietary: List<String>.from(json['dietary']),
      location: Location.fromJson(json['location']),
      openingHours: OpeningHours.fromJson(json['openingHours']),
      popularItems: PopularItems.fromJson(json['popularItems']),
      reviewInsights: ReviewInsights.fromJson(json['reviewInsights']),
      engagement: Engagement.fromJson(json['engagement']),
      userReviews: UserReviews.fromJson(json['userReviews']),
    );
  }
}

class Location {
  final String title;
  final String address;
  final Coordinates coordinates;

  Location({
    required this.title,
    required this.address,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      title: json['title'],
      address: json['address'],
      coordinates: Coordinates.fromJson(json['coordinates']),
    );
  }
}

class Coordinates {
  final double lat;
  final double lng;

  Coordinates({required this.lat, required this.lng});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }
}

class OpeningHours {
  final String title;
  final List<String> hours;

  OpeningHours({required this.title, required this.hours});

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      title: json['title'],
      hours: List<String>.from(json['hours']),
    );
  }
}

class PopularItems {
  final String title;
  final List<MenuItem> items;

  PopularItems({required this.title, required this.items});

  factory PopularItems.fromJson(Map<String, dynamic> json) {
    return PopularItems(
      title: json['title'],
      items: (json['items'] as List<dynamic>)
          .map((e) => MenuItem.fromJson(e))
          .toList(),
    );
  }
}

class MenuItem {
  final String name;
  final String price;
  final String description;

  MenuItem({
    required this.name,
    required this.price,
    required this.description,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'],
      price: json['price'],
      description: json['description'],
    );
  }
}

class ReviewInsights {
  final double averageRating;
  final Sentiment sentiment;

  ReviewInsights({
    required this.averageRating,
    required this.sentiment,
  });

  factory ReviewInsights.fromJson(Map<String, dynamic> json) {
    return ReviewInsights(
      averageRating: (json['averageRating'] as num).toDouble(),
      sentiment: Sentiment.fromJson(json['sentiment']),
    );
  }
}

class Sentiment {
  final int positive;
  final int neutral;
  final int negative;

  Sentiment({
    required this.positive,
    required this.neutral,
    required this.negative,
  });

  factory Sentiment.fromJson(Map<String, dynamic> json) {
    return Sentiment(
      positive: json['positive'],
      neutral: json['neutral'],
      negative: json['negative'],
    );
  }
}

class Engagement {
  final Mentions mentions;

  Engagement({required this.mentions});

  factory Engagement.fromJson(Map<String, dynamic> json) {
    return Engagement(
      mentions: Mentions.fromJson(json['mentions']),
    );
  }
}

class Mentions {
  final int instagram;
  final int tiktok;
  final int reddit;

  Mentions({
    required this.instagram,
    required this.tiktok,
    required this.reddit,
  });

  factory Mentions.fromJson(Map<String, dynamic> json) {
    return Mentions(
      instagram: json['Instagram'],
      tiktok: json['TikTok'],
      reddit: json['Reddit'],
    );
  }
}

class UserReviews {
  final String title;
  final double averageRating;
  final List<UserReview>? reviews;

  UserReviews({
    required this.title,
    required this.averageRating,
    this.reviews,
  });

  factory UserReviews.fromJson(Map<String, dynamic> json) {
    return UserReviews(
      title: json['title'],
      averageRating: (json['averageRating'] as num).toDouble(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => UserReview.fromJson(e))
          .toList(),
    );
  }
}

class UserReview {
  final String quote;
  final String source;

  UserReview({required this.quote, required this.source});

  factory UserReview.fromJson(Map<String, dynamic> json) {
    return UserReview(
      quote: json['quote'],
      source: json['source'],
    );
  }
}
