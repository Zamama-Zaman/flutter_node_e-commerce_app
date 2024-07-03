import 'package:flutter/foundation.dart';

import '../../../common/models/cart_model.dart';
import '../../../lib.dart';

class OrderResModel {
  final String id;
  final String subTotal;
  final String deliveryAddress;
  final UserDetail userDetail;
  final List<CartModel> cart;
  final String status;
  final String createdAt;
  OrderResModel({
    required this.id,
    required this.subTotal,
    required this.deliveryAddress,
    required this.userDetail,
    required this.cart,
    required this.status,
    required this.createdAt,
  });

  OrderResModel copyWith({
    String? id,
    String? subTotal,
    String? deliveryAddress,
    UserDetail? userDetail,
    List<CartModel>? cart,
    String? status,
    String? createdAt,
  }) {
    return OrderResModel(
      id: id ?? this.id,
      subTotal: subTotal ?? this.subTotal,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      userDetail: userDetail ?? this.userDetail,
      cart: cart ?? this.cart,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'subTotal': subTotal,
      'deliveryAddress': deliveryAddress,
      'userDetail': userDetail.toMap(),
      'cart': cart.map((x) => x.toMap()).toList(),
      'status': status.toString(),
      'createdAt': createdAt,
    };
  }

  factory OrderResModel.fromMap(Map<String, dynamic> map) {
    debugPrint("What is the type of ${map['createdAt'].runtimeType}");
    return OrderResModel(
      id: map['_id'] as String,
      subTotal: map['subTotal'].toString(),
      deliveryAddress: map['deliveryAddress'] as String,
      userDetail: UserDetail.fromMap(map['userDetail'] as Map<String, dynamic>),
      cart: List<CartModel>.from(
        (map['cart']).map<CartModel>(
          (x) => CartModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      status: map['status'].toString(),
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderResModel.fromJson(String source) =>
      OrderResModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderResModel(id: $id, subTotal: $subTotal, deliveryAddress: $deliveryAddress, userDetail: $userDetail, cart: $cart)';
  }

  @override
  bool operator ==(covariant OrderResModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.subTotal == subTotal &&
        other.deliveryAddress == deliveryAddress &&
        other.userDetail == userDetail &&
        other.status == status &&
        other.createdAt == createdAt &&
        listEquals(other.cart, cart);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        subTotal.hashCode ^
        deliveryAddress.hashCode ^
        userDetail.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        cart.hashCode;
  }
}
