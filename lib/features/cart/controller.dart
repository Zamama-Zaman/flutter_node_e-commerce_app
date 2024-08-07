import '../../common/models/cart_model.dart';
import '../../services/product_service/product_service.dart';

import '../../lib.dart';

class CartController extends BaseController {
  static final instance = Get.find<CartController>();

  // List<CartUIModel> cartList = [
  //   CartUIModel(
  //     image: "https://m.media-amazon.com/images/I/718b9wK3eaL._AC_SL1500_.jpg",
  //     name: "Logitech G502 Lightspeed Wireless Gaming Mouse",
  //     price: 99.00,
  //   ),
  //   CartUIModel(
  //     image: "https://m.media-amazon.com/images/I/610yFgBrH6L._AC_SL1500_.jpg",
  //     name: "DIERYA T68SE 60% Gaming Mechanical Keyboard",
  //     price: 23.00,
  //   ),
  //   CartUIModel(
  //     image: "https://m.media-amazon.com/images/I/71tJLLp+x+L._AC_SL1500_.jpg",
  //     name: "SteelSeries New Arctis Nova 3 Multi-Platform Gaming Headset",
  //     price: 1500.00,
  //   ),
  //   CartUIModel(
  //     image:
  //         "https://images-na.ssl-images-amazon.com/images/G/01/AmazonExports/Events/2023/EBF23/Fuji_Desktop_Single_image_EBF_2x_v1._SY608_CB573698005_.jpg",
  //     name: "Apple iPhone 13(128 GB) - Midnight/Black/Blue",
  //     price: 1500.00,
  //   ),
  // ];

  List<CartModel>? listCart;
  Future<void> getCart() async {
    listCart = await ProductService.instance.getCart();
    update();
  }

  // add to cart
  void addToCart({
    required CartModel data,
  }) async {
    final isAdded = await ProductService.instance.addToCart(
      product: data.product,
    );

    isAdded.fold((errorM) {
      Fluttertoast.showToast(msg: errorM);
    }, (successM) {
      data = data.copyWith(
        quantity: data.quantity++,
      );
      update();
      Fluttertoast.showToast(msg: successM);
    });
  }

  void removeFromCart({
    required CartModel data,
  }) async {
    bool isRemoved = await ProductService.instance.removeFromCart(
      product: data.product,
    );

    if (data.quantity == 1) {
      await getCart();
    }

    if (isRemoved) {
      data = data.copyWith(
        quantity: data.quantity--,
      );
      update();

      Fluttertoast.showToast(msg: "Cart Remove Successfully");
    }
  }
}
