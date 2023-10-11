import 'package:assessment_test/auth/create_account.dart';
import 'package:assessment_test/bottom_nav.dart';
import 'package:assessment_test/service/auth_service.dart';
import 'package:assessment_test/utils/components.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAccount extends StatelessWidget {
  LoginAccount({super.key});
  final userName = TextEditingController();
  final pwd = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                const Text(
                  'Login to your account',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Don\'t have any account?',
                      style: TextStyle(
                        color: Color(0xFF434343),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () => Get.to(CreateAccount()),
                      child: Text(
                        'Create Account',
                        style: const TextStyle(
                          color: Color(0xFF2676FC),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 41),
                AppTextField(
                  controller: userName,
                  hintText:
                      'enter your full name as its written on your id card',
                  title: 'Username',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                AppTextField(
                  controller: pwd,
                  hintText: 'password must be at least 6 characters long',
                  title: 'Password',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                ),
                Spacer(),
                AppButton(
                  title: 'Login',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      AuthService().login(
                        password: pwd.text,
                        userName: userName.text,
                      );
                    }
                    // Get.to(BottomNav());
                  },
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
