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

  void login() async {
    bool isNotEmpty =
        (loginEmailCtrl.text.isNotEmpty && loginPassCtrl.text.isNotEmpty);
    if (isNotEmpty) {
      final result = await AuthService.instance.login(
        email: loginEmailCtrl.text.trim(),
        password: loginPassCtrl.text.trim(),
      );

      result.fold((errorM) {
        Fluttertoast.showToast(msg: errorM);
      }, (succesR) {
        final response = succesR;
        AppPreference.instance.setUserModel(model: succesR);

        response.type == "admin"
            ? Get.offAll(() => const AdminView())
            : Get.offAll(() => const DefaultView());
      });
    }
  }

  void register() async {
    bool isNotEmpty = (regisEmailCtrl.text.isNotEmpty &&
        regisPassCtrl.text.isNotEmpty &&
        regisNameCtrl.text.isNotEmpty);
    if (isNotEmpty) {
      final result = await AuthService.instance.register(
        name: regisNameCtrl.text.trim(),
        email: regisEmailCtrl.text.trim(),
        password: regisPassCtrl.text.trim(),
      );

      result.fold((errorM) {
        Fluttertoast.showToast(msg: errorM);
      }, (succesM) {
        Get.offAll(() => const LoginView());
        Fluttertoast.showToast(msg: succesM);
      });
    }
  }
}
