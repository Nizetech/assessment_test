import 'package:assessment_test/auth/login_account.dart';
import 'package:assessment_test/bottom_nav.dart';
import 'package:assessment_test/utils/components.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({super.key});
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final address = TextEditingController();
  final cPwd = TextEditingController();
  final mail = TextEditingController();
  final pwd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              const Text(
                'Create Account',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Have an account?',
                      style: TextStyle(
                        color: Color(0xFF434343),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                    ),
                    const TextSpan(
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
                        ..onTap = () => Get.to(() => LoginAccount()),
                      text: 'Login',
                      style: const TextStyle(
                        color: Color(0xFF2676FC),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 0.10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              AppTextField(
                controller: firstName,
                hintText: 'enter your full name as its written on your id card',
                title: 'First Name',
              ),
              SizedBox(height: 18),
              AppTextField(
                controller: lastName,
                hintText: 'enter your full name as its written on your id card',
                title: 'Last Name',
              ),
              SizedBox(height: 18),
              AppTextField(
                controller: userName,
                hintText: 'enter your full name as its written on your id card',
                title: 'Username',
              ),
              SizedBox(height: 18),
              AppTextField(
                controller: mail,
                hintText: 'example@gmail.com',
                title: 'Email Address',
              ),
              SizedBox(height: 18),
              AppTextField(
                controller: pwd,
                hintText: 'password must be at least 6 characters long',
                title: 'Password',
              ),
              SizedBox(height: 18),
              AppTextField(
                controller: cPwd,
                hintText: 'password must be at least 6 characters long',
                title: 'Confirm Password',
              ),
              SizedBox(height: 18),
              AppButton(
                title: 'Create Account',
                onPressed: () {
                  Get.to(BottomNav());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
