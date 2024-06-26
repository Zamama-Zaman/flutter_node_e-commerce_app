import 'package:flutter_node_ecommerce_app_original/common/models/cart_model.dart';
import 'package:flutter_node_ecommerce_app_original/services/product_service/product_service.dart';

import '../../lib.dart';

class CartController extends BaseController {
  static final instance = Get.find<CartController>();

  int addQuantity(quantity) {
    return quantity++;
  }

  int removeQuantity(quantity) {
    if (quantity != 0) {
      return quantity--;
    } else {
      return 0;
    }
  }

  List<CartUIModel> cartList = [
    CartUIModel(
      image: "https://m.media-amazon.com/images/I/718b9wK3eaL._AC_SL1500_.jpg",
      name: "Logitech G502 Lightspeed Wireless Gaming Mouse",
      price: 99.00,
    ),
    CartUIModel(
      image: "https://m.media-amazon.com/images/I/610yFgBrH6L._AC_SL1500_.jpg",
      name: "DIERYA T68SE 60% Gaming Mechanical Keyboard",
      price: 23.00,
    ),
    CartUIModel(
      image: "https://m.media-amazon.com/images/I/71tJLLp+x+L._AC_SL1500_.jpg",
      name: "SteelSeries New Arctis Nova 3 Multi-Platform Gaming Headset",
      price: 1500.00,
    ),
    CartUIModel(
      image:
          "https://images-na.ssl-images-amazon.com/images/G/01/AmazonExports/Events/2023/EBF23/Fuji_Desktop_Single_image_EBF_2x_v1._SY608_CB573698005_.jpg",
      name: "Apple iPhone 13(128 GB) - Midnight/Black/Blue",
      price: 1500.00,
    ),
  ];

  List<CartModel>? listCart;
  void getCart() async {
    listCart = await ProductService.instance.getCart();
    update();
  }
}
