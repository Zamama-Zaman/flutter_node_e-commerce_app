import '../../../lib.dart';

// ignore: must_be_immutable
class CartModel extends Equatable {
  final String image;
  final String name;
  final double price;
  late int quantity;

  CartModel({
    required this.image,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  CartModel copyWith({
    String? image,
    String? name,
    double? price,
    int? quantity,
  }) {
    return CartModel(
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object> get props => [
        image,
        name,
        price,
        quantity,
      ];
}
