import 'package:flutter_node_ecommerce_app_original/common/models/cart_model.dart';

import '../../lib.dart';

class ProductService {
  static final instance = ProductService();

  Map<String, String> get headers => {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AppPreference.instance.getUserModel.token}'
      };

  /// add to cart
  Future<bool> addToCart({required Product product}) async {
    bool isAddToCart = false;
    final myJsonEncode = json.encode({
      "productId": product.id,
    });

    try {
      Response response = await post(
        Uri.parse(AppBaseUrl.addToCartUrl),
        body: myJsonEncode,
        headers: headers,
      );

      if (response.statusCode == 200) {
        isAddToCart = true;
      }
      if (response.statusCode == 401) {
        debugPrint("Error Add to Cart UnAuthorise ${headers['Authorization']}");
        Fluttertoast.showToast(msg: "UnAuthorise ${headers['Authorization']}");
      }
    } catch (e) {
      debugPrint("Error Add to Cart $e");
      Fluttertoast.showToast(msg: "Error Add to Cart $e");
    }

    return isAddToCart;
  }

  Future<List<CartModel>> getCart() async {
    List<CartModel> cartList = [];

    try {
      Response response = await get(
        Uri.parse(AppBaseUrl.getCartUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        for (var cart in jsonDecode(response.body)['body']['cart']) {
          cartList.add(CartModel.fromMap(cart));
        }
      }
      if (response.statusCode == 401) {
        debugPrint("Error Get Cart UnAuthorise ${headers['Authorization']}");
        Fluttertoast.showToast(msg: "UnAuthorise ${headers['Authorization']}");
      }
    } catch (e) {
      debugPrint("Error Get Cart $e");
      Fluttertoast.showToast(msg: "Error Get Cart $e");
    }

    return cartList;
  }

  Future<bool> removeFromCart({required Product product}) async {
    bool isRemoveFromCart = false;
    final myJsonEncode = json.encode({
      "productId": product.id,
    });

    try {
      Response response = await post(
        Uri.parse(AppBaseUrl.removeFromCartUrl),
        body: myJsonEncode,
        headers: headers,
      );

      if (response.statusCode == 200) {
        isRemoveFromCart = true;
      }
      if (response.statusCode == 401) {
        debugPrint(
            "Error Remove From Cart UnAuthorise ${headers['Authorization']}");
        Fluttertoast.showToast(msg: "UnAuthorise ${headers['Authorization']}");
      }
    } catch (e) {
      debugPrint("Error Remove From Cart $e");
      Fluttertoast.showToast(msg: "Error Remove From Cart $e");
    }

    return isRemoveFromCart;
  }

  Future<bool> rateAProduct({
    required Product product,
    required String rate,
  }) async {
    bool isRated = false;
    final myJsonEncode = json.encode({
      "rate": rate,
      "productId": product.id,
    });

    debugPrint("myJson Encode is ${myJsonEncode}");

    // try {
    //   Response response = await post(
    //     Uri.parse(AppBaseUrl.rateAProduct),
    //     body: myJsonEncode,
    //     headers: headers,
    //   );

    //   if (response.statusCode == 200) {
    //     isRated = true;
    //   }
    //   if (response.statusCode == 401) {
    //     debugPrint(
    //         "Error Rate a Product UnAuthorise ${headers['Authorization']}");
    //     Fluttertoast.showToast(msg: "UnAuthorise ${headers['Authorization']}");
    //   }
    // } catch (e) {
    //   debugPrint("Error Rate a Product $e");
    //   Fluttertoast.showToast(msg: "Error Rate a Product $e");
    // }

    return isRated;
  }
}
