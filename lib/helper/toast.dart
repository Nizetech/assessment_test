import 'package:assessment_test/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessToast {
  SuccessToast({required String message}) {
    Get.snackbar(
      duration: const Duration(seconds: 2),
      colorText: Colors.white,
      'Success',
      message,
      backgroundColor: mainColor,
    );
  }
}

class ErrorToast {
  ErrorToast({required String message}) {
    Get.snackbar(
      duration: const Duration(seconds: 2),
      colorText: Colors.white,
      'Error',
      message,
      backgroundColor: Colors.red,
    );
  }
}
