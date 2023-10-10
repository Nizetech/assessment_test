import 'package:assessment_test/auth/create_account.dart';
import 'package:assessment_test/bottom_nav.dart';
import 'package:assessment_test/utils/components.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAccount extends StatelessWidget {
  LoginAccount({super.key});
  final email = TextEditingController();
  final pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Don\'t Have an account?',
                      style: TextStyle(
                        color: Color(0xFF434343),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                    ),
                    TextSpan(
                      text: ' ',
                      style: TextStyle(
                        color: Color(0xFF2676FC),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(() => CreateAccount());
                        },
                      text: 'Create Account',
                      style: TextStyle(
                        color: Color(0xFF2676FC),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 0.10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 41),
              AppTextField(
                controller: email,
                hintText: 'example@gmail.com',
                title: 'Email Address',
              ),
              SizedBox(height: 20),
              AppTextField(
                controller: pwd,
                hintText: 'password must be at least 6 characters long',
                title: 'Password',
              ),
              Spacer(),
              AppButton(
                title: 'Login',
                onPressed: () {
                  Get.to(BottomNav());
                },
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
