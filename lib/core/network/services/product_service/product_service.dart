import 'package:flutter_node_ecommerce_app_original/common/models/cart_model.dart';

import '../../../../lib.dart';

class ProductService {
  static final instance = ProductService();
  final client = CustomHttpClientMiddleWare(Client());

  Map<String, String> get headers => {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AppPreference.instance.getUserModel.token}',
        'Accept-Language': AppPreference.instance.getLocale,
      };

  /// add to cart
  Future<Either<String, String>> addToCart({required Product product}) async {
    final myJsonEncode = json.encode({
      "productId": product.id,
    });

    try {
      Response response = await client.post(
        Uri.parse(AppBaseUrl.addToCartUrl),
        body: myJsonEncode,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final myDecodedRes = json.decode(response.body);
        return right(myDecodedRes['message']);
      } else {
        final myDecodedRes = json.decode(response.body);
        return left(myDecodedRes['message']);
      }
    } catch (e) {
      debugPrint("Error Add to Cart $e");
      Fluttertoast.showToast(msg: "Error Add to Cart $e");
    }

    return left("Error Add to Cart");
  }

  Future<Either<String, List<CartModel>>> getCart() async {
    List<CartModel> cartList = [];

    try {
      Response response = await client.get(
        Uri.parse(AppBaseUrl.getCartUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        for (var cart in jsonDecode(response.body)['body']['cart']) {
          cartList.add(CartModel.fromMap(cart));
        }
        return right(cartList);
      } else {
        final myDecodedRes = json.decode(response.body);
        return left(myDecodedRes['message']);
      }
    } catch (e) {
      debugPrint("Error Get Cart $e");
      return left("Error Get Cart $e");
    }
  }

  Future<Either<String, String>> removeFromCart(
      {required Product product}) async {
    final myJsonEncode = json.encode({
      "productId": product.id,
    });

    try {
      Response response = await client.post(
        Uri.parse(AppBaseUrl.removeFromCartUrl),
        body: myJsonEncode,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final myDecodedRes = json.decode(response.body);
        return right(myDecodedRes['message']);
      } else {
        final myDecodedRes = json.decode(response.body);
        return left(myDecodedRes['message']);
      }
    } catch (e) {
      debugPrint("Error Remove From Cart $e");
      return left("Error Remove From Cart $e");
    }
  }

  Future<Either<String, String>> rateAProduct({
    required Product product,
    required String rate,
  }) async {
    final myJsonEncode = json.encode({
      "rate": rate,
      "productId": product.id,
    });

    try {
      Response response = await client.post(
        Uri.parse(AppBaseUrl.rateAProduct),
        body: myJsonEncode,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final myDecodedRes = json.decode(response.body);
        return right(myDecodedRes['message']);
      } else {
        final myDecodedRes = json.decode(response.body);
        return left(myDecodedRes['message']);
      }
    } catch (e) {
      debugPrint("Error Rate a Product $e");
      return left("Error Rate a Product $e");
    }
  }
}
