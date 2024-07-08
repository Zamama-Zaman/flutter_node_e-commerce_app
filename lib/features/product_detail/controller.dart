import '../../services/product_service/product_service.dart';

import '../../lib.dart';

class ProductController extends BaseController {
  static final instance = Get.find<ProductController>();

  //********** Product Detail View ************//

  double avgRating = 0;
  double myRating = 0;

  void initFunction() {
    // double totalRating = 0;
    // for (int i = 0; i < product.rating!.length; i++) {
    //   totalRating += product.rating![i].rating;
    //   if (product.rating![i].userId ==
    //       Provider.of<UserProvider>(context, listen: false).user.id) {
    //     myRating = widget.product.rating![i].rating;
    //   }
    // }

    // if (totalRating != 0) {
    //   avgRating = totalRating / product.rating!.length;
    // }
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
      Fluttertoast.showToast(msg: "Rated Successfully");
      Get.close();
    }
  }
}
