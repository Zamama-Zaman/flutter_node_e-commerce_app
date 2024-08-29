import '../../../../lib.dart';

class HomeService {
  static final instance = HomeService();
  CustomHttpClientMiddleWare client = CustomHttpClientMiddleWare(Client());
  AppPreference appPreference = AppPreference.instance;

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<Either<String, List<Product>>> getProductByCategory({
    required String category,
  }) async {
    List<Product> products = [];

    final myJsonEncode = json.encode({
      "category": category,
    });
    headers['Accept-Language'] = appPreference.getLocale;

    try {
      Response response = await client.post(
        Uri.parse(AppBaseUrl.getProductsByCategory),
        body: myJsonEncode,
        headers: headers,
      );

      if (response.statusCode == 200) {
        for (var product in jsonDecode(response.body)['data']) {
          products.add(Product.fromMap(product));
        }
        return right(products);
      } else {
        final myDecodedRes = json.decode(response.body);
        return left(myDecodedRes['message']);
      }
    } catch (e) {
      debugPrint("Product by Category Error $e");
      return left("Product by Category Error $e");
    }
  }

  Future<Either<String, List<Product>>> searchProduct(
      {required String search}) async {
    List<Product> searchedProducts = [];
    headers['Accept-Language'] = appPreference.getLocale;
    try {
      Response response = await client.get(
        Uri.parse("${AppBaseUrl.getProduct}$search"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        for (var product in jsonDecode(response.body)['data']) {
          searchedProducts.add(Product.fromMap(product));
        }
        return right(searchedProducts);
      } else {
        debugPrint("Search Product Error ${response.statusCode}");
        final myDecodedRes = json.decode(response.body);
        return left(myDecodedRes['message']);
      }
    } catch (e) {
      debugPrint("Search Product Error $e");
      Fluttertoast.showToast(msg: "Error Search Product $e");
      return left("Search Product Error $e");
    }
  }

  Future<Either<String, List<Product>>> topRatedProducts() async {
    List<Product> topRated = [];
    headers['Accept-Language'] = AppPreference.instance.getLocale;
    try {
      Response response = await client.get(
        Uri.parse(AppBaseUrl.topRatedProductsUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        for (var product in jsonDecode(response.body)['body']) {
          topRated.add(Product.fromMap(product));
        }
        return right(topRated);
      } else {
        debugPrint("Top Rated Products Error ${response.statusCode}");
        final myDecodedRes = json.decode(response.body);
        return left(myDecodedRes['message']);
      }
    } catch (e) {
      debugPrint("Top Rated Product Error $e");
      Fluttertoast.showToast(msg: "Error Top Rated Product $e");
      return left("Top Rated Product Error $e");
    }
  }
}
