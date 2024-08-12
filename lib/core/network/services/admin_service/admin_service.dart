import '../../../../lib.dart';

class AdminService {
  static final instance = AdminService();
  final client = CustomHttpClientMiddleWare(Client());
  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Map<String, String> get headers => {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AppPreference.instance.getUserModel.token}',
        'Accept-Language': AppPreference.instance.getLocale,
      };

  Future<Either<String, String>> addProduct({
    required Product product,
    required List<File> images,
  }) async {
    final cloudinary = CloudinaryPublic('dm0exb8fh', 'tlg4hfwb');
    List<String> imageUrls = [];

    for (int i = 0; i < images.length; i++) {
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          images[i].path,
          folder: product.name,
        ),
      );
      imageUrls.add(res.secureUrl);
    }

    product = product.copyWith(images: imageUrls);

    try {
      Response response = await client.post(
        Uri.parse(AppBaseUrl.addProductUrl),
        body: product.toJson(),
        headers: headers,
      );

      if (response.statusCode == 201) {
        final myDecodedRes = json.decode(response.body);
        return right(myDecodedRes['message']);
      } else {
        final myDecodedRes = json.decode(response.body);
        return left(myDecodedRes['message']);
      }
    } catch (e) {
      debugPrint("Error add Product $e");
      return left("Error add Product $e");
    }
  }

  Future<Either<String, List<Product>>> fetchAllProducts() async {
    List<Product> products = [];
    try {
      Response response = await client.get(
        Uri.parse(AppBaseUrl.fetchAllProductUrl),
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
      debugPrint("Error fetch all Products $e");
      Fluttertoast.showToast(msg: "Error fetch all Products $e");
      return left("Error fetch all Products $e");
    }
  }

  Future<Either<String, String>> deletAProduct(
      {required Product product}) async {
    try {
      Response response = await client.post(
        Uri.parse(AppBaseUrl.deleteAProduct),
        headers: _headers,
        body: product.toJson(),
      );

      if (response.statusCode == 200) {
        final myDecodedRes = json.decode(response.body);
        return right(myDecodedRes['message']);
      } else {
        final myDecodedRes = json.decode(response.body);
        return left(myDecodedRes['message']);
      }
    } catch (e) {
      debugPrint("Delete a Product $e");
      return left("Delete a Product $e");
    }
  }

  Future<Either<String, List<OrderResModel>>> fetchAllOrders() async {
    List<OrderResModel> orders = [];
    try {
      Response response = await client.get(
        Uri.parse(AppBaseUrl.fetchAllOrders),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        for (var singleOrder in jsonDecode(response.body)['body']) {
          orders.add(OrderResModel.fromMap(singleOrder));
        }
        return right(orders);
      } else {
        final myDecodedRes = json.decode(response.body);
        return left(myDecodedRes['message']);
      }
    } catch (e) {
      debugPrint("Error to Fetch all orders $e");
      Fluttertoast.showToast(msg: "Error to Fetch all orders $e");
      return left("Error to Fetch all orders $e");
    }
  }
}
