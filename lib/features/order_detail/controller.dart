import '../../lib.dart';

class OrderController extends BaseController {
  static final instance = Get.find<OrderController>();

  int currentStep = 0;

  void initFunction({required Order order}) {
    currentStep = order.status;
  }

  // !!! ONLY FOR ADMIN!!!
  void changeOrderStatus({required int status, required Order order}) {
    // adminServices.changeOrderStatus(
    //   status: status + 1,
    //   order: order,
    //   onSuccess: () {
    //     currentStep += 1;
    //     update();
    //   },
    // );
  }
}
