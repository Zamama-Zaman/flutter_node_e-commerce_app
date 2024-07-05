import '../../lib.dart';

class OrderController extends BaseController {
  static final instance = Get.find<OrderController>();

  int currentStep = 0;

  void initFunction({required Order order}) {
    currentStep = order.status;
    update();
  }
}
