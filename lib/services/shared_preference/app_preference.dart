import '../../lib.dart';

class AppPreference {
  static final instance = AppPreference();
  final _userKey = "USER_MODEL";

  late SharedPreferences _preferences;
  Future<void> initiatePreference() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> setUserModel({required UserModel model}) async =>
      await _preferences.setString(_userKey, model.toJson());

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
    String? userEncoded = _preferences.getString(_userKey);
    if (userEncoded != null) {
      user = UserModel.fromJson(userEncoded);
    }
    return user;
  }

  bool isUserLogin() {
    bool isLoggedIn = false;
    String? userEncoded = _preferences.getString(_userKey);
    if (userEncoded != null) {
      final user = UserModel.fromJson(userEncoded);
      if (user.token.isNotEmpty) {
        isLoggedIn = true;
      }
    }

    return isLoggedIn;
  }

  Future<bool> clearUser() async => await _preferences.clear();
}
