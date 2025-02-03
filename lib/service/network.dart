import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:santapan_fe/main.dart';
import 'package:santapan_fe/models/response_model.dart';
import 'package:santapan_fe/pages/auth/signin_page.dart';
import 'package:santapan_fe/data/utils/auth_utils.dart';

class NetworkCaller {
  Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url), headers: {
        'Authorization': 'Bearer ${AuthUtility.accessToken}',
        'Accept': 'application/json'
      });
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        moveToLogin();
      } else {
        return NetworkResponse(
          false,
          response.statusCode,
          null,
        );
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(
      false,
      -1,
      null,
    );
  }

  Future<NetworkResponse> postRequest(
    String url,
    Map<String, dynamic>? body,
  ) async {
    try {
      print(AuthUtility.accessToken);
      Response response = await post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AuthUtility.accessToken}',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
      } else {
        return NetworkResponse(
          false,
          response.statusCode,
          null,
        );
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(
      false,
      -1,
      null,
    );
  }

  Future<NetworkResponse> putRequest(
    String url,
    Map<String, dynamic>? body,
  ) async {
    try {
      Response response = await put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${AuthUtility.accessToken}',
        },
        body: jsonEncode(body),
      );
      log("${response.statusCode.toString()} ${response.body}");
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
      } else {
        return NetworkResponse(
          false,
          response.statusCode,
          null,
        );
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(
      false,
      -1,
      null,
    );
  }

}
void moveToLogin() async {
  await AuthUtility.clearUserInfo();

  // Check if currentState is not null before accessing context
  final navigatorState = Santapan.navigatorKey.currentState;
  if (navigatorState != null) {
    final BuildContext context = navigatorState.context;

    // Ensure the context is available and navigate to the login screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SigninPage()),
    );
  } else {
    return;
  }
}