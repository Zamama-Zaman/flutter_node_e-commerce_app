import 'package:flutter_node_ecommerce_app_original/services/order_service/order_service.dart';

import '../../lib.dart';

class AccountController extends BaseController {
  static final instancer = Get.find<AccountController>();

  void logout() {
    AppPreference.instance.clearUser();
    Get.offAll(() => const LoginView());
  }

  List<OrderResModel>? orderList = [];
  void getOrders() async {
    orderList = await OrderService.instance.getAllOrders();

    if (orderList != null && orderList!.isNotEmpty) {
      Fluttertoast.showToast(msg: "Orders Fetched Successfully");
    }

    update();
  }
}
