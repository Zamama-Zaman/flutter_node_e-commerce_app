import '../../lib.dart';

class ProductController extends BaseController {
  static final instance = Get.find<ProductController>();

  //********** Product Detail View ************//

  double avgRating = 0;
  double myRating = 0;
  void initFunction({required Product product}) {
    avgRating = 0;
    myRating = 0;
    final String currentId = AppPreference.instance.getUserModel.id;
    double totalRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
      if (product.rating![i].userId == currentId) {
        myRating = product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }
    update();
  }

  void addToCart({required Product product}) async {
    bool isAddToCart =
        await ProductService.instance.addToCart(product: product);

    if (isAddToCart) {
      Fluttertoast.showToast(msg: "Add To Cart Successfully");
      Get.back();
    }
  }

  void rateAProduct({
    required Product product,
    required String rate,
  }) async {
    bool isRated = await ProductService.instance.rateAProduct(
      product: product,
      rate: rate,
    );

    if (isRated) {
      await HomeController.instance.fetchCategoryProducts();
      update();
      Fluttertoast.showToast(msg: "Rated Successfully");
      Get.close();
    }
  }

  //* need to add search field.
  //* needed to add top rated.
  //* Then Add localization in Arabic.
  //* After that Chat between different users.
  //* Chat with sockets add.
}
