import '../../lib.dart';

class CartModel {
  final String id;
  int quantity;
  final Product product;
  CartModel({
    required this.id,
    required this.quantity,
    required this.product,
  });

  CartModel copyWith({
    String? id,
    int? quantity,
    Product? product,
  }) {
    return CartModel(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'quantity': quantity,
      'product': product.toMap(),
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['_id'] as String,
      quantity: map['quantity'] as int,
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CartModel(id: $id, quantity: $quantity, product: $product)';

  @override
  bool operator ==(covariant CartModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.quantity == quantity &&
        other.product == product;
  }

  @override
  int get hashCode => id.hashCode ^ quantity.hashCode ^ product.hashCode;
}
