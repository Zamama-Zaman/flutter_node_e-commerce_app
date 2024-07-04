import '../../lib.dart';

class AdminService {
  static final instance = AdminService();
  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<bool> addProduct({
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

    bool isAdded = false;
    try {
      Response response = await post(
        Uri.parse(AppBaseUrl.addProductUrl),
        body: product.toJson(),
        headers: _headers,
      );

      if (response.statusCode == 201) {
        isAdded = true;
      }
    } catch (e) {
      debugPrint("Error add Product $e");
      Fluttertoast.showToast(msg: "Error add Product $e");
    }

    return isAdded;
  }

  Future<List<Product>> fetchAllProducts() async {
    List<Product> products = [];
    try {
      Response response = await get(
        Uri.parse(AppBaseUrl.fetchAllProductUrl),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        for (var product in jsonDecode(response.body)['data']) {
          products.add(Product.fromMap(product));
        }
      }
    } catch (e) {
      debugPrint("Error fetch all Products $e");
      Fluttertoast.showToast(msg: "Error fetch all Products $e");
    }

    return products;
  }

  Future<bool> deletAProduct({required Product product}) async {
    bool isDeleted = false;
    try {
      Response response = await post(
        Uri.parse(AppBaseUrl.deleteAProduct),
        headers: _headers,
        body: product.toJson(),
      );

      if (response.statusCode == 200) {
        isDeleted = true;
      }
    } catch (e) {
      debugPrint("Delete a Product $e");
      Fluttertoast.showToast(msg: "Delete a Product $e");
    }

    return isDeleted;
  }

  Future<List<OrderResModel>> fetchAllOrders() async {
    List<OrderResModel> orders = [];
    try {
      Response response = await get(
        Uri.parse(AppBaseUrl.fetchAllOrders),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        for (var singleOrder in jsonDecode(response.body)['body']) {
          orders.add(OrderResModel.fromMap(singleOrder));
        }
      }
    } catch (e) {
      debugPrint("Error to Fetch all orders $e");
      Fluttertoast.showToast(msg: "Error to Fetch all orders $e");
    }

    return orders;
  }
}
