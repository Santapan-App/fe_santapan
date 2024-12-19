import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:santapan_fe/models/login_model.dart';

class AuthUtility {
  static User userInfo = User();
  static String? accessToken;
  static String? refreshToken;

  //* Save user data and tokens to shared preferences
  static Future<void> setUserInfo(User model, String? token, String? refresh) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Save user data
    await sharedPreferences.setString("user_data", jsonEncode(model.toJson()));
    userInfo = model;

    // Save tokens
    if (token != null) {
      await sharedPreferences.setString("access_token", token);
      accessToken = token;
    }
    if (refresh != null) {
      await sharedPreferences.setString("refresh_token", refresh);
      refreshToken = refresh;
    }
  }

  //* Retrieve user data from shared preferences
  static Future<User> getUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String value = sharedPreferences.getString("user_data")!;
    return User.fromJson(jsonDecode(value));
  }

  //* Retrieve access token
  static Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("access_token");
  }

  //* Retrieve refresh token
  static Future<String?> getRefreshToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("refresh_token");
  }

  //* Clear all user data and tokens from shared preferences
  static Future<void> clearUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    userInfo = User();
    accessToken = null;
    refreshToken = null;
  }

  //* Check if the user is logged in
  static Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLogin = sharedPreferences.containsKey("user_data");
    if (isLogin) {
      userInfo = await getUserInfo();
      accessToken = await getAccessToken();
      refreshToken = await getRefreshToken();
    }
    return isLogin;
  }
}
