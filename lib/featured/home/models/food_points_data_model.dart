class FoodPointsDataModel {
  final String imageUrl;
  final String name;
  final double rating;
  final String cuisine;
  final String address;
  final bool isOpen;
  final int priceLevel;
  final int deliveryTime;
  final List<String> features;
  final List<OpeningHours> openingHours;
  final List<MenuItem> popularItems;
  final ReviewInsights reviewInsights;
  final List<UserReview> userReviews;

  FoodPointsDataModel({
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.cuisine,
    required this.address,
    required this.isOpen,
    required this.priceLevel,
    required this.deliveryTime,
    required this.features,
    required this.openingHours,
    required this.popularItems,
    required this.reviewInsights,
    required this.userReviews,
  });

  static List<FoodPointsDataModel> getSampleRestaurantsFromIslamabad() {
    return [
      FoodPointsDataModel(
        imageUrl: 'assets/images/1.jpg',
        name: 'Monal Restaurant',
        rating: 4.5,
        cuisine: 'Pakistani',
        address: 'Pir Sohawa Road, Islamabad',
        isOpen: true,
        priceLevel: 3,
        deliveryTime: 45,
        features: ['Scenic View', 'Outdoor Seating'],
        openingHours: [
          OpeningHours(day: 'Monday', time: '12:00 PM - 11:00 PM'),
          OpeningHours(day: 'Tuesday', time: '12:00 PM - 11:00 PM'),
        ],
        popularItems: [
          MenuItem(name: 'BBQ Platter', price: 'PKR 1500', description: 'Delicious BBQ platter.'),
        ],
        reviewInsights: ReviewInsights(insights: {'Positive': 90, 'Negative': 10}),
        userReviews: [
          UserReview(name: 'Ali', rating: 4.5, date: '2023-01-01', comment: 'Amazing food and view!'),
        ],
      ),
      FoodPointsDataModel(
        imageUrl: 'assets/images/2.jpg',
        name: 'Tuscany Courtyard',
        rating: 4.2,
        cuisine: 'Italian',
        address: 'Kohsar Market, Islamabad',
        isOpen: true,
        priceLevel: 4,
        deliveryTime: 40,
        features: ['Fine Dining', 'Romantic Ambiance'],
        openingHours: [
          OpeningHours(day: 'Monday', time: '1:00 PM - 11:00 PM'),
          OpeningHours(day: 'Tuesday', time: '1:00 PM - 11:00 PM'),
        ],
        popularItems: [
          MenuItem(name: 'Pasta Alfredo', price: 'PKR 1200', description: 'Creamy Alfredo pasta.'),
        ],
        reviewInsights: ReviewInsights(insights: {'Positive': 85, 'Negative': 15}),
        userReviews: [
          UserReview(name: 'Sara', rating: 4.2, date: '2023-01-02', comment: 'Great Italian food!'),
        ],
      ),
      FoodPointsDataModel(
        imageUrl: 'assets/images/3.jpg',
        name: 'Sushi Center',
        rating: 4.7,
        cuisine: 'Japanese',
        address: 'F-10 Markaz, Islamabad',
        isOpen: true,
        priceLevel: 5,
        deliveryTime: 50,
        features: ['Sushi Bar', 'Private Booths'],
        openingHours: [
          OpeningHours(day: 'Monday', time: '1:00 PM - 10:00 PM'),
          OpeningHours(day: 'Tuesday', time: '1:00 PM - 10:00 PM'),
        ],
        popularItems: [
          MenuItem(name: 'California Roll', price: 'PKR 1800', description: 'Fresh California roll sushi.'),
        ],
        reviewInsights: ReviewInsights(insights: {'Positive': 92, 'Negative': 8}),
        userReviews: [
          UserReview(name: 'John', rating: 4.7, date: '2023-01-03', comment: 'Best sushi in town!'),
        ],
      ),
      FoodPointsDataModel(
        imageUrl: 'assets/images/4.jpg',
        name: 'The Great Wall',
        rating: 4.0,
        cuisine: 'Chinese',
        address: 'G-11, Islamabad',
        isOpen: true,
        priceLevel: 3,
        deliveryTime: 30,
        features: ['Takeaway', 'Family Friendly'],
        openingHours: [
          OpeningHours(day: 'Monday', time: '11:00 AM - 10:00 PM'),
          OpeningHours(day: 'Tuesday', time: '11:00 AM - 10:00 PM'),
        ],
        popularItems: [
          MenuItem(name: 'Kung Pao Chicken', price: 'PKR 1300', description: 'Spicy stir-fried chicken.'),
        ],
        reviewInsights: ReviewInsights(insights: {'Positive': 80, 'Negative': 20}),
        userReviews: [
          UserReview(name: 'Mary', rating: 4.0, date: '2023-01-04', comment: 'Tasty Chinese food.'),
        ],
      ),
      FoodPointsDataModel(
        imageUrl: 'assets/images/5.jpg',
        name: 'Delhi Darbar',
        rating: 4.3,
        cuisine: 'Indian',
        address: 'F-7, Islamabad',
        isOpen: true,
        priceLevel: 3,
        deliveryTime: 40,
        features: ['Buffet', 'Live Music'],
        openingHours: [
          OpeningHours(day: 'Monday', time: '12:00 PM - 11:00 PM'),
          OpeningHours(day: 'Tuesday', time: '12:00 PM - 11:00 PM'),
        ],
        popularItems: [
          MenuItem(name: 'Biryani', price: 'PKR 900', description: 'Aromatic basmati rice with spices and meat.'),
        ],
        reviewInsights: ReviewInsights(insights: {'Positive': 87, 'Negative': 13}),
        userReviews: [
          UserReview(name: 'Raj', rating: 4.3, date: '2023-01-05', comment: 'Authentic Indian cuisine.'),
        ],
      ),
      FoodPointsDataModel(
        imageUrl: 'assets/images/1.jpg',
        name: 'KFC',
        rating: 4.1,
        cuisine: 'Fast Food',
        address: 'F-6, Islamabad',
        isOpen: true,
        priceLevel: 2,
        deliveryTime: 25,
        features: ['Drive-Thru', 'Takeaway'],
        openingHours: [
          OpeningHours(day: 'Monday', time: '10:00 AM - 12:00 AM'),
          OpeningHours(day: 'Tuesday', time: '10:00 AM - 12:00 AM'),
        ],
        popularItems: [
          MenuItem(name: 'Zinger Burger', price: 'PKR 700', description: 'Crispy chicken burger.'),
        ],
        reviewInsights: ReviewInsights(insights: {'Positive': 82, 'Negative': 18}),
        userReviews: [
          UserReview(name: 'Ali', rating: 4.1, date: '2023-01-06', comment: 'Good fast food experience.'),
        ],
      ),
      FoodPointsDataModel(
        imageUrl: 'assets/images/7.jpg',
        name: 'Nandos',
        rating: 4.6,
        cuisine: 'Portuguese',
        address: 'F-8, Islamabad',
        isOpen: true,
        priceLevel: 3,
        deliveryTime: 30,
        features: ['Spicy Food', 'Casual Dining'],
        openingHours: [
          OpeningHours(day: 'Monday', time: '11:00 AM - 11:00 PM'),
          OpeningHours(day: 'Tuesday', time: '11:00 AM - 11:00 PM'),
        ],
        popularItems: [
          MenuItem(name: 'Peri-Peri Chicken', price: 'PKR 1100', description: 'Grilled chicken with peri-peri sauce.'),
        ],
        reviewInsights: ReviewInsights(insights: {'Positive': 90, 'Negative': 10}),
        userReviews: [
          UserReview(name: 'Sara', rating: 4.6, date: '2023-01-07', comment: 'Love the spicy chicken!'),
        ],
      ),
      FoodPointsDataModel(
        imageUrl: 'assets/images/8.jpg',
        name: 'Dunkin Donuts',
        rating: 4.4,
        cuisine: 'Cafe',
        address: 'F-10, Islamabad',
        isOpen: true,
        priceLevel: 2,
        deliveryTime: 20,
        features: ['Desserts', 'Coffee'],
        openingHours: [
          OpeningHours(day: 'Monday', time: '8:00 AM - 10:00 PM'),
          OpeningHours(day: 'Tuesday', time: '8:00 AM - 10:00 PM'),
        ],
        popularItems: [
          MenuItem(name: 'Chocolate Glazed Donut', price: 'PKR 400', description: 'Delicious chocolate donut.'),
        ],
        reviewInsights: ReviewInsights(insights: {'Positive': 85, 'Negative': 15}),
        userReviews: [
          UserReview(name: 'John', rating: 4.4, date: '2023-01-08', comment: 'Best donuts in town!'),
        ],
      ),
      FoodPointsDataModel(
        imageUrl: 'assets/images/9.jpg',
        name: 'Hardees',
        rating: 4.0,
        cuisine: 'Fast Food',
        address: 'G-10, Islamabad',
        isOpen: true,
        priceLevel: 2,
        deliveryTime: 30,
        features: ['Drive-Thru', 'Takeaway'],
        openingHours: [
          OpeningHours(day: 'Monday', time: '10:00 AM - 11:00 PM'),
          OpeningHours(day: 'Tuesday', time: '10:00 AM - 11:00 PM'),
        ],
        popularItems: [
          MenuItem(name: 'Charbroiled Burger', price: 'PKR 750', description: 'Juicy charbroiled burger.'),
        ],
        reviewInsights: ReviewInsights(insights: {'Positive': 80, 'Negative': 20}),
        userReviews: [
          UserReview(name: 'Mary', rating: 4.0, date: '2023-01-09', comment: 'Good fast food joint.'),
        ],
      ),
      FoodPointsDataModel(
        imageUrl: 'assets/images/10.jpg',
        name: 'Street 1 Cafe',
        rating: 4.3,
        cuisine: 'Continental',
        address: 'Street 1, F-6/3, Islamabad',
        isOpen: true,
        priceLevel: 3,
        deliveryTime: 35,
        features: ['Cozy Environment', 'Great Coffee'],
        openingHours: [
          OpeningHours(day: 'Monday', time: '9:00 AM - 11:00 PM'),
          OpeningHours(day: 'Tuesday', time: '9:00 AM - 11:00 PM'),
        ],
        popularItems: [
          MenuItem(name: 'Grilled Chicken Sandwich', price: 'PKR 800', description: 'Tasty grilled chicken sandwich.'),
        ],
        reviewInsights: ReviewInsights(insights: {'Positive': 88, 'Negative': 12}),
        userReviews: [
          UserReview(name: 'Ahmed', rating: 4.3, date: '2023-01-10', comment: 'Perfect place for brunch!'),
        ],
      ),
    ];
  }
}

class OpeningHours {
  final String day;
  final String time;

  OpeningHours({required this.day, required this.time});
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
}

class ReviewInsights {
  final Map<String, int> insights;

  ReviewInsights({required this.insights});
}

class UserReview {
  final String name;
  final double rating;
  final String date;
  final String comment;

  UserReview({
    required this.name,
    required this.rating,
    required this.date,
    required this.comment,
  });
}