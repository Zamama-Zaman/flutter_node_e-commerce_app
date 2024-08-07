import '../../lib.dart';

class AuthService {
  static final instance = AuthService();
  final client = CustomHttpClientMiddleWare(Client());
  Map<String, String> get _headers => {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept-Language': AppPreference.instance.getLocale,
  };

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    UserModel? user;
    final myJsonEncode = json.encode({
      "email": email,
      "password": password,
    });

    try {
      Response response = await client.post(
        Uri.parse(AppBaseUrl.loginUrl),
        body: myJsonEncode,
        headers: _headers,
      );

      if (response.statusCode == 200) {
        user = UserModel.fromMap(jsonDecode(response.body)['body']['user']);
        user = user.copyWith(token: jsonDecode(response.body)['body']['token']);
        AppPreference.instance.setUserModel(model: user);
      } else {
        Fluttertoast.showToast(msg: "${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Login Error $e");
      Fluttertoast.showToast(msg: "Error Login $e");
    }

    return user;
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
      Response response = await client.post(
        Uri.parse(AppBaseUrl.registerUrl),
        body: myJsonEncode,
        headers: _headers,
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
    }

    return isRegister;
  }
}
