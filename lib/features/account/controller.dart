import '../../lib.dart';

class AccountController extends BaseController {
  static final instancer = Get.find<AccountController>();

  void logout() {
    AppPreference.instance.clearUser();
    Get.offAll(() => const LoginView());
  }

  List<OrderResModel>? orderList = [];
  void getOrders() async {
    orderList = await OrderService.instance.getAllMyOrders();

    if (orderList != null && orderList!.isNotEmpty) {
      debugPrint("Orders Fetched Successfully");
      update();
    }
  }
}
