import '../../lib.dart';

class HomeService {
  static final instance = HomeService();

  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<List<Product>> getProductByCategory({
    required String category,
  }) async {
    List<Product> products = [];

    final myJsonEncode = json.encode({
      "category": category,
    });

    try {
      Response response = await post(
        Uri.parse(AppBaseUrl.getProductsByCategory),
        body: myJsonEncode,
        headers: _headers,
      );

      if (response.statusCode == 200) {
        for (var product in jsonDecode(response.body)['data']) {
          products.add(Product.fromMap(product));
        }
      }
    } catch (e) {
      debugPrint("Product by Category Error $e");
      Fluttertoast.showToast(msg: "Error Product by Category $e");
    }

    return products;
  }

  Future<List<Product>> searchProduct({required String search}) async {
    List<Product> searchedProducts = [];
    try {
      Response response = await get(
        Uri.parse("${AppBaseUrl.getProduct}$search"),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        for (var product in jsonDecode(response.body)['data']) {
          searchedProducts.add(Product.fromMap(product));
        }
      } else {
        debugPrint("Search Product Error ${response.statusCode}");
        Fluttertoast.showToast(
            msg: "Error Search Product ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Search Product Error $e");
      Fluttertoast.showToast(msg: "Error Search Product $e");
    }

    return searchedProducts;
  }

  Future<List<Product>> topRatedProducts() async {
    List<Product> topRated = [];
    try {
      Response response = await get(
        Uri.parse(AppBaseUrl.topRatedProductsUrl),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        for (var product in jsonDecode(response.body)['body']) {
          topRated.add(Product.fromMap(product));
        }
      } else {
        debugPrint("Top Rated Products Error ${response.statusCode}");
        Fluttertoast.showToast(
            msg: "Error Top Rated Product ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Top Rated Product Error $e");
      Fluttertoast.showToast(msg: "Error Top Rated Product $e");
    }

    return topRated;
  }
}
