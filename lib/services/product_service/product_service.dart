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
        debugPrint("Error Add to Cart UnAuthorise ${headers}");
        Fluttertoast.showToast(msg: "UnAuthorise ${headers}");
      }
    } catch (e) {
      debugPrint("Error Add to Cart $e");
      Fluttertoast.showToast(msg: "Error Add to Cart $e");
    }

    return isAddToCart;
  }

  Future<bool> getCart() async {
    bool isFetched = false;

    try {
      Response response = await get(
        Uri.parse(AppBaseUrl.getCartUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        isFetched = true;
      }
      if (response.statusCode == 401) {
        debugPrint("Error Get Cart UnAuthorise ${headers}");
        Fluttertoast.showToast(msg: "UnAuthorise ${headers}");
      }
    } catch (e) {
      debugPrint("Error Get Cart $e");
      Fluttertoast.showToast(msg: "Error Get Cart $e");
    }

    return isFetched;
  }
}
