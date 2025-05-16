import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:roamsavvy/core/constants/app_urls.dart';
import 'package:roamsavvy/data/network/base_api_services.dart';
import 'package:roamsavvy/data/response/api_response.dart';
import 'package:roamsavvy/featured/home/models/food_place_model.dart';
import 'package:roamsavvy/featured/home/models/nearby_places_response.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Timer? _headingTimer;
  final BaseApiServices baseApiServices;
  HomeBloc(this.baseApiServices) : super(const HomeState()) {
    on<ToggleIsEditingEvent>(_onToggleIsEditing);
    on<StartHeadingAnimationEvent>(_onStartHeadingAnimation);
    on<CompleteHeadingAnimationEvent>(_onCompleteHeadingAnimation);
    on<RotateHeadingEvent>(_onRotateHeading);
    on<ToggleExpandedWidget>(_onToggleExpandedWidget);
    on<GetNearByFoodPointsEvent>(_getFoodNearByPoints);
    add(const RotateHeadingEvent());
  }

  void _onToggleIsEditing(ToggleIsEditingEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(isEditing: !state.isEditing));
  }

  void _onStartHeadingAnimation(
    StartHeadingAnimationEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(isHeadingAnimating: true));

    // Schedule completion of animation - increased from 4000ms to 6000ms
    Future.delayed(const Duration(milliseconds: 5000), () {
      add(const CompleteHeadingAnimationEvent());
    });
  }

  void _onCompleteHeadingAnimation(
    CompleteHeadingAnimationEvent event,
    Emitter<HomeState> emit,
  ) {
    final nextIndex =
        (state.currentHeadingIndex + 1) % 4; // Assuming 4 headings
    emit(
      state.copyWith(currentHeadingIndex: nextIndex, isHeadingAnimating: false),
    );
  }

  void _onRotateHeading(RotateHeadingEvent event, Emitter<HomeState> emit) {
    // Cancel existing timer if any
    _headingTimer?.cancel();

    // Create a new timer that triggers animation every 7 seconds (increased from 5)
    _headingTimer = Timer.periodic(const Duration(seconds: 7), (timer) {
      if (!state.isHeadingAnimating) {
        add(const StartHeadingAnimationEvent());
      }
    });
  }

  void _onToggleExpandedWidget(
    ToggleExpandedWidget event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(isExpanded: !state.isExpanded));
  }

  Future<void> _getFoodNearByPoints(
    GetNearByFoodPointsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(apiresponse: Apiresponse.loading()));
    try {
      final queryParams = {
        'location': '${event.lat},${event.lng}',
        'radius': '1500',
        'type': 'restaurant',
        'keyword': 'restaurant cafe bar food Bakery',
        'key': 'YOUR_GOOGLE_MAPS_API_KEY',
      };

      final uri = Uri.parse(
        AppUrls.nearbyRestaurants,
      ).replace(queryParameters: queryParams);

      // 1. Fetch from Google Maps API
      final googleResponse = await baseApiServices.getGetApiResponse(
        uri.toString(),
      );

      // 2. Parse Google Maps response
      final places = NearbySearchResponse.fromJson(googleResponse);

      // 4. Call Gemini (with proper implementation)
      final geminiResponse = await sendToGeminiAPI(places);

      // 5. Emit the final response
      emit(state.copyWith(apiresponse: Apiresponse.completed(geminiResponse)));
    } catch (e) {
      emit(state.copyWith(apiresponse: Apiresponse.error(e.toString())));
    }
  }

  Future<FoodPlacesResponse> sendToGeminiAPI(
    NearbySearchResponse placeData,
  ) async {
    final apiKey = Platform.environment['GEMINI_API_KEY'];
    if (apiKey == null) {
      throw Exception('GEMINI_API_KEY environment variable not set!');
    }

    final simplifiedPlaces = placeData.toJson();

    final geminiRequestPayload = {
      'contents': [
        {
          'parts': [
            {
              'text':
                  '''You are given a list of food-related locations retrieved from Google Maps based on queries like “food points near me,” “cafe,” “bar,” “bakery,” “fast food,” etc.

🧠 Task:
For each location, gather comprehensive metadata by scraping across:

The web (Google, Yelp, TripAdvisor, local directories)

Major social platforms: Reddit, Quora, Facebook, X (Twitter), TikTok, Instagram, LinkedIn, and Pinterest.

📦 Your output must be a structured and uniform JSON for each location using the schema below, following these rules:
✅ Normalize and Extract:
High-resolution image URLs (de-duplicated using multiple references via Google Place Details API and socials)

Place ID (from Google Maps, used to fetch additional data)

Name, address, contact information, cuisine type

Open status (isOpen)

Average rating (aggregated from Google + social platform reviews, based on sentiment analysis)

Normalized price range in USD (e.g., "\$10 - \$20")

Estimated wait time in minutes (via web or social mentions)

Peak hours when busiest (e.g., "Fri: 7:00 PM–9:00 PM"), via Google Popular Times or crowd mentions

Features and tags (e.g., "WiFi", "Outdoor Seating", "Live Music"), extracted from web and social platforms

Dietary options (e.g., "Vegan", "Halal", "Gluten-Free"), along with source annotation (e.g., "Facebook")

Full location details with GPS coordinates

Opening hours in 12-hour format, e.g., "Mon: 9:00 AM–10:00 PM"

Popular menu items (3–5), with name, price in USD, and brief description

Review insights:

Average rating (aggregated from Google + social media)

Sentiment breakdown: % positive, % neutral, % negative

2–3 user quotes from social platforms (short and relevant)

Engagement metrics:

Mentions on Instagram, TikTok, and Reddit (quantified)


🧾 JSON Schema:
json
{
"results":[
{
  "placeId": "",
  "image": "",
  "name": "",
  "rating": 0.0,
  "cuisine": "",
  "address": "",
  "contact": "",
  "isOpen": true,
  "priceRange": "\$10 - \$20",
  "waitTime": 0,
  "peakHours": [],
  "features": [],
  "dietary": [],
  "location": {
    "title": "",
    "address": "",
    "coordinates": {
      "lat": 0.0,
      "lng": 0.0
    }
  },
  "openingHours": {
    "title": "Opening Hours",
    "hours": []
  },
  "popularItems": {
    "title": "Popular Items",
    "items": []
  },
  "reviewInsights": {
    "averageRating": 0.0,
    "sentiment": {
      "positive": 0,
      "neutral": 0,
      "negative": 0
    },
  },
  "engagement": {
    "mentions": {
      "Instagram": 0,
      "TikTok": 0,
      "Reddit": 0
    }
  },
  "userReviews": {
    "title": "User Reviews",
    "averageRating": 0.0
  }
}]}
⚠️ Additional Validation Rules:
Always include the placeId for each location.

Do not leave any field empty or null unless data is genuinely unavailable after searching web and socials.

Ratings must be evaluated from both Google + social reviews, using NLP to determine weighted sentiment and return to-the-point numeric value.

De-duplicate images, features, and menu items.

Avoid extra notes or parentheses in the final JSON—only return concise values.

Use 12-hour format for all time fields, including peak and opening hours.

Cover all food points returned by Google Maps, regardless of query variation. ${simplifiedPlaces.toString()}''',
            },
          ],
        },
      ],
      'generation_config': {
        'temperature': 1,
        'top_p': 0.8,
        'top_k': 40,
        'max_output_tokens': 2048, // Increased token limit
      },
    };

    final geminiEndpoint =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-flash:generateContent';

    try {
      final response = await baseApiServices.postApiResponse(
        '$geminiEndpoint?key=AIzaSyA3ndujUhYZfA9q_puc5PZcg9Kkb6MFCp0',
        geminiRequestPayload,
      );

      // Validate the response structure *before* parsing
      if (response is Map &&
          response.containsKey('candidates') &&
          response['candidates'] is List &&
          response['candidates'].isNotEmpty &&
          response['candidates'][0] is Map &&
          response['candidates'][0].containsKey('content') &&
          response['candidates'][0]['content'] is Map &&
          response['candidates'][0]['content'].containsKey('parts') &&
          response['candidates'][0]['content']['parts'] is List &&
          response['candidates'][0]['content']['parts'].isNotEmpty &&
          response['candidates'][0]['content']['parts'][0] is Map &&
          response['candidates'][0]['content']['parts'][0].containsKey(
            'text',
          )) {
        final geminiContent =
            response['candidates'][0]['content']['parts'][0]['text'];

        try {
          // Attempt to parse the JSON
          final parsedJson = jsonDecode(geminiContent); // Decode JSON string
          return FoodPlacesResponse.fromJson(parsedJson); // Then, use fromJson
        } on FormatException catch (e) {
          print('JSON parsing error: ${e.toString()}');
          print('Problematic JSON: $geminiContent'); // Log the invalid JSON
          throw Exception(
            'Failed to parse Gemini response: Invalid JSON format. ${e.toString()}',
          );
        } catch (e) {
          print('Error during FoodPlacesResponse.fromJson: ${e.toString()}');
          throw Exception('Error creating FoodPlacesResponse: ${e.toString()}');
        }
      } else {
        print(
          "Unexpected Gemini API response: ${jsonEncode(response)}",
        ); // Log full response
        throw Exception(
          'Failed to parse Gemini response: Invalid response format.',
        );
      }
    } catch (e) {
      print('Error calling Gemini API: ${e.toString()}');
      throw Exception('Failed to call Gemini API: ${e.toString()}');
    }
  }

  @override
  Future<void> close() {
    _headingTimer?.cancel();
    return super.close();
  }
}
