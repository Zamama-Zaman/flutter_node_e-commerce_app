// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../lib.dart';

class Product extends Equatable {
  final String adminId;
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  final List<Rating>? rating;
  const Product({
    required this.adminId,
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'adminId': adminId,
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      '_id': id,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      adminId: map['adminId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity'] != null ? double.parse(map['quantity']) : 0.0,
      images: map['images'] != null ? List<String>.from(map['images']) : [],
      category: map['category'] ?? '',
      price: map['price'] != null ? double.parse(map['price']) : 0.0,
      id: map['_id'],
      rating: map['rating'] != null
          ? List<Rating>.from(
              map['rating']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  Product copyWith({
    String? adminId,
    String? name,
    String? description,
    double? quantity,
    List<String>? images,
    String? category,
    double? price,
    String? id,
    List<Rating>? rating,
  }) {
    return Product(
      adminId: adminId ?? this.adminId,
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      images: images ?? this.images,
      category: category ?? this.category,
      price: price ?? this.price,
      id: id ?? this.id,
      rating: rating ?? this.rating,
    );
  }

  @override
  List<Object?> get props => [
        adminId,
        name,
        description,
        quantity,
        images,
        category,
        price,
        id,
        rating,
      ];
}
