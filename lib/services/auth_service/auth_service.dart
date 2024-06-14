import '../../lib.dart';

class AuthService {
  static final instance = AuthService();
  Client client = Client();

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    bool isLogin = false;
    final myJsonEncode = json.encode({
      "email": email,
      "password": password,
    });

    try {
      Response response = await post(
        Uri.parse(AppBaseUrl.loginUrl),
        body: myJsonEncode,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        isLogin = true;
      } else {
        isLogin = false;
        Fluttertoast.showToast(msg: "${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Login Error $e");
      Fluttertoast.showToast(msg: "Error Login $e");
      // throw Exception(e);
    }

    return isLogin;
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    bool isRegister = false;
    final myJsonEncode = json.encode({
      "name": name,
      "email": email,
      "password": password,
    });

    try {
      Response response = await post(
        Uri.parse(AppBaseUrl.registerUrl),
        body: myJsonEncode,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 201) {
        isRegister = true;
      } else {
        isRegister = false;
        debugPrint(
            "Register Error ${response.statusCode} message ${response.body}");
        Fluttertoast.showToast(msg: "${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Register Error $e");
      Fluttertoast.showToast(msg: "Error Register $e");
      // throw Exception(e);
    }

    return isRegister;
  }
}
