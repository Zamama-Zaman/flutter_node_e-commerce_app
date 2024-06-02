import '../../lib.dart';

class AuthController extends BaseController {
  static final instancer = Get.find<AuthController>();

  final loginEmailCtrl = TextEditingController();
  final loginPassCtrl = TextEditingController();

  final regisEmailCtrl = TextEditingController();
  final regisPassCtrl = TextEditingController();
  final regisNameCtrl = TextEditingController();

  bool loginPassVisible = false;
  void updateLoginPass() {
    loginPassVisible = !loginPassVisible;
    update();
  }

  bool regisPassVisible = false;
  void updateRegisPass() {
    regisPassVisible = !regisPassVisible;
    update();
  }
}
