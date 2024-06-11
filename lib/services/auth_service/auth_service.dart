import '../../lib.dart';

class AuthService {
  static final instance = AuthService();
  Client client = Client();

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    bool isLogin = false;
    try {
      Response response = await client.post(
        Uri.parse(AppBaseUrl.loginUrl),
        body: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        isLogin = true;
      }
    } catch (e) {
      throw Exception(e);
    }

    return isLogin;
  }
}
