import 'dart:developer';

import 'package:assessment_test/auth/login_account.dart';
import 'package:assessment_test/bottom_nav.dart';
import 'package:assessment_test/constant/api_constant.dart';
import 'package:assessment_test/helper/loading.dart';
import 'package:assessment_test/helper/toast.dart';
import 'package:assessment_test/utils/api_response.dart';
import 'package:assessment_test/utils/network_clients.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class AuthService {
  final client = NetworkClient();
  Box box = Hive.box(kAppName);

  // Register User
  Future<
      // ApiResponse<dynamic>
      bool> register({
    required String firstName,
    required String lastName,
    required String password,
    required String password2,
    required String email,
    required String userName,
    required BuildContext context,
  }) async {
    try {
      ProgressHelper().showLoader('Please wait...');
      final response = await client.post(ApiRoute.register, body: {
        'email': email,
        'first_name': firstName,
        'username': userName,
        'last_name': lastName,
        'password': password,
        'password2': password2,
      });
      log(response.toString());
      ProgressHelper.hideLoader();
      Get.to(LoginAccount());
      return true;
    } catch (e) {
      // ProgressHelper.hideLoader();
      Navigator.pop(context);
      log(e.toString());
      ErrorToast(message: e.toString());

      return false;
    }
  }

  // Login User
  Future<bool> login({
    required String password,
    required String userName,
    required BuildContext context,
  }) async {
    try {
      ProgressHelper().showLoader('Please wait...');
      final response = await client.post(ApiRoute.login, body: {
        'username': userName,
        'password': password,
      });
      log(response.toString());
      await box.put('token', response['access']);
      ProgressHelper.hideLoader();
      SuccessToast(message: 'Login Successful');
      Get.to(BottomNav());
      return true;
    } catch (e) {
      Navigator.pop(context);

      log(e.toString());
      ErrorToast(message: e.toString());

      return false;
    }
  }

  // Login User
  Future<bool> home({
    required String password,
    required String userName,
  }) async {
    try {
      String token = await box.get('token');

      ProgressHelper().showLoader('Please wait...');
      final response = await client.get(ApiRoute.login, requestHeaders: {
        "Authorization": "Bearer $token",
      });
      log(response.toString());
      await box.put('token', response['access']);
      ProgressHelper.hideLoader();
      Get.to(LoginAccount());
      return true;
    } catch (e) {
      print('object');
      // ProgressHelper.hideLoader();
      Get.back(closeOverlays: true);
      // log(e.toString());
      // ErrorToast(message: e.toString());

      return false;
    }
  }
}
