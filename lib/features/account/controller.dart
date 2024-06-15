import '../../lib.dart';

class AccountController extends BaseController {
  static final instancer = Get.find<AccountController>();

  void logout() {
    AppPreference.instance.clearUser();
    Get.offAll(() => const LoginView());
  }
}
