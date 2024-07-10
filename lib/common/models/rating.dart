import 'dart:convert';

class Rating {
  final String userId;
  final double rating;
  Rating({
    required this.userId,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'rate': rating,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      userId: map['userId'] ?? '',
      rating: map['rate'] != null ? double.parse(map['rate']) : 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));
}
