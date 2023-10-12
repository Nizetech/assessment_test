import 'package:assessment_test/auth/login_account.dart';
import 'package:assessment_test/bottom_nav.dart';
import 'package:assessment_test/service/auth_service.dart';
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
  final email = TextEditingController();
  final pwd = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 11),
                Row(
                  children: [
                    Text(
                      'Have an account?',
                      style: TextStyle(
                        color: Color(0xFF434343),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () => Get.to(LoginAccount()),
                      child: Text(
                        'Login',
                        style: const TextStyle(
                          color: Color(0xFF2676FC),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                AppTextField(
                  controller: firstName,
                  hintText:
                      'enter your full name as its written on your id card',
                  title: 'First Name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 18),
                AppTextField(
                  controller: lastName,
                  hintText:
                      'enter your full name as its written on your id card',
                  title: 'Last Name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 18),
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
                SizedBox(height: 18),
                AppTextField(
                  controller: email,
                  hintText: 'example@gmail.com',
                  title: 'Email Address',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email address';
                    } else if (!value.isEmail) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 18),
                AppTextField(
                  controller: pwd,
                  hintText: 'password must be at least 8 characters long',
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
                SizedBox(height: 18),
                AppTextField(
                  controller: cPwd,
                  hintText: 'password must be at least 8 characters long',
                  title: 'Confirm Password',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .13),
                AppButton(
                  title: 'Create Account',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      AuthService().register(
                        firstName: firstName.text,
                        lastName: lastName.text,
                        password: pwd.text,
                        password2: cPwd.text,
                        email: email.text,
                        userName: userName.text,
                        context: context,
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
