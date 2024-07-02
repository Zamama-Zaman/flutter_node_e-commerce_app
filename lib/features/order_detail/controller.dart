import 'package:flutter_node_ecommerce_app_original/services/order_service/order_service.dart';

import '../../lib.dart';

class OrderController extends BaseController {
  static final instance = Get.find<OrderController>();

  int currentStep = 0;

  void initFunction({required Order order}) {
    currentStep = order.status;
  }

  // !!! ONLY FOR ADMIN!!!
  void changeOrderStatus({required int status, required Order order}) async {
    bool isChanged = await OrderService.instance.changeOrderStatus(
      orderId: order.id,
      status: (status + 1).toString(),
    );

    if (isChanged) {
      Fluttertoast.showToast(msg: "Status changed Successfully");
      currentStep += 1;
      update();
    }
  }
}
