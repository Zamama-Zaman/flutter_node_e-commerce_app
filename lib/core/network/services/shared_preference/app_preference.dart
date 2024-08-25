import '../../../../lib.dart';

class AppPreference {
  static final instance = AppPreference();
  final _userKey = "USER_MODEL";
  final _localKey = "LOCALE";

  late SharedPreferences preferences;
  Future<void> initiatePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<bool> setUserLocale({required String locale}) async =>
      await preferences.setString(
        _localKey,
        locale,
      );

  String get getLocale => preferences.getString(_localKey) ?? "en";

  Future<bool> setUserModel({required UserModel model}) async =>
      await preferences.setString(_userKey, model.toJson());

  UserModel get getUserModel {
    UserModel user = UserModel(
      name: "",
      id: "",
      password: "",
      email: "",
      address: "",
      type: "",
      token: "",
      cart: [],
    );
    String? userEncoded = preferences.getString(_userKey);
    if (userEncoded != null) {
      user = UserModel.fromJson(userEncoded);
    }
    return user;
  }

  bool isUserLogin() {
    bool isLoggedIn = false;
    String? userEncoded = preferences.getString(_userKey);
    if (userEncoded != null) {
      final user = UserModel.fromJson(userEncoded);
      if (user.token.isNotEmpty) {
        isLoggedIn = true;
      }
    }

    return isLoggedIn;
  }

  Future<bool> clearUser() async => await preferences.clear();
}
