import '../../lib.dart';

class ProductService {
  static final instance = ProductService();

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${AppPreference.instance.getUserModel().token}'
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
        debugPrint(
            "Error Add to Cart UnAuthorise ${AppPreference.instance.getUserModel().token}");
        Fluttertoast.showToast(
            msg: "UnAuthorise ${AppPreference.instance.getUserModel().token}");
      }
    } catch (e) {
      debugPrint("Error Add to Cart $e");
      Fluttertoast.showToast(msg: "Error Add to Cart $e");
    }

    return isAddToCart;
  }
}
