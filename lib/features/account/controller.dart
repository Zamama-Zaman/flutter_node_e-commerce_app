import '../../lib.dart';

class AccountController extends BaseController {
  static final instancer = Get.find<AccountController>();

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
