import '../../../../lib.dart';

class AuthService {
  static final instance = AuthService();
  CustomHttpClientMiddleWare client = CustomHttpClientMiddleWare(Client());
  AppPreference appPreInstance = AppPreference.instance;

  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      UserModel? user;
      final myJsonEncode = json.encode({
        "email": email,
        "password": password,
      });
      headers['Accept-Language'] = appPreInstance.getLocale;

      //
      Response response = await client.post(
        Uri.parse(AppBaseUrl.loginUrl),
        body: myJsonEncode,
        headers: headers,
      );

      if (response.statusCode == 200) {
        user = UserModel.fromMap(jsonDecode(response.body)['body']['user']);
        user = user.copyWith(token: jsonDecode(response.body)['body']['token']);
        return right(user);
      } else {
        final myDecodedRes = json.decode(response.body);
        return left(myDecodedRes['message']);
      }
    } catch (e) {
      debugPrint("Login Error $e");
      return left("Login Error $e");
    }
  }

  Future<Either<String, String>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final myJsonEncode = json.encode({
      "name": name,
      "email": email,
      "password": password,
    });
    headers['Accept-Language'] = appPreInstance.getLocale;

    try {
      Response response = await client.post(
        Uri.parse(AppBaseUrl.registerUrl),
        body: myJsonEncode,
        headers: headers,
      );

      if (response.statusCode == 201) {
        final myDecodedRes = json.decode(response.body);
        return Right(myDecodedRes['message']);
      } else {
        final myDecodedRes = json.decode(response.body);
        return Left(myDecodedRes['message']);
      }
    } catch (e) {
      debugPrint("Register Error $e");
      return Left("Register Error $e");
    }
  }
}
