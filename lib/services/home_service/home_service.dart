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
}
