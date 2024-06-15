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
}
