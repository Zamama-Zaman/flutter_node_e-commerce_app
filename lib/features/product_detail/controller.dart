import '../../lib.dart';

class ProductController extends BaseController {
  static final instance = Get.find<ProductController>();
  late Product? product;

  //********** Product Detail View ************//

  double avgRating = 0;
  double myRating = 0;
  void initFunction({required Product product}) {
    this.product = product;
    avgRating = 0;
    myRating = 0;
    final String currentId = AppPreference.instance.getUserModel.id;
    double totalRating = 0;
    for (int i = 0; i < this.product!.rating!.length; i++) {
      totalRating += this.product!.rating![i].rating;
      if (this.product!.rating![i].userId == currentId) {
        myRating = this.product!.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / this.product!.rating!.length;
    }
    update();
  }

  void addToCart() async {
    bool isAddToCart =
        await ProductService.instance.addToCart(product: product!);

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
      final newProduct = HomeController.instance.productList!
          .firstWhere((ele) => ele.id == product.id);
      initFunction(product: newProduct);
      update();
      Get.close();
      await Fluttertoast.showToast(msg: "Rated Successfully");
    }
  }
}
