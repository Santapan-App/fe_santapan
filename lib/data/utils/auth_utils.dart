import 'dart:convert';

import 'package:santapan_fe/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtility {
  static LoginModel userInfo = LoginModel();

  static Future<void> setUserInfo(LoginModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("user_data", jsonEncode(model.toJson()));
    userInfo = model;
  }

  //*this method is used to get user data from shared preferences.

  static Future<LoginModel> getUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String value = sharedPreferences.getString("user_data")!;
    return LoginModel.fromJson(jsonDecode(value));
  }

  //*this method is used to clear user data from shared preferences.

  static Future<void> clearUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  static Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLogin = sharedPreferences.containsKey("user_data");
    if (isLogin) {
      userInfo = (await getUserInfo());
    }
    return isLogin;
  }
}
