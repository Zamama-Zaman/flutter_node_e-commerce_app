import '../../lib.dart';

class AccountController extends BaseController {
  static final instancer = Get.find<AccountController>();

  void logout() {
    AppPreference.instance.clearUser();
    Get.offAll(() => const LoginView());
  }

  List<OrderResModel>? orderList = [];
  void getOrders() async {
    final result = await OrderService.instance.getAllMyOrders();

    result.fold((errorM) {
      Fluttertoast.showToast(msg: errorM);
    }, (succesM) {
      orderList = succesM;
      if (orderList != null && orderList!.isNotEmpty) {
        debugPrint("Orders Fetched Successfully");
        update();
      }
    });
  }

  void changeLanguage() {
    if (isEng) {
      Get.context!.setLocale(const Locale('ar'));
      Get.updateLocale(const Locale("ar"));
    } else {
      Get.context!.setLocale(const Locale('en'));
      Get.updateLocale(const Locale("en"));
    }

    update();
  }
}
