import 'dart:developer';

import 'package:assessment_test/auth/create_account.dart';
import 'package:assessment_test/auth/login_account.dart';
import 'package:assessment_test/bottom_nav.dart';
import 'package:assessment_test/constant/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'provider/chat_provider.dart';
// import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter(kAppName);
  await Hive.openBox(kAppName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  Box box = Hive.box(kAppName);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String? token = box.get('token');
    if (token != null) {
      log(token.toString());
    }
    return ChangeNotifierProvider<ChatProvider>(
        create: (context) => ChatProvider(),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Test App',
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                elevation: 0,
                backgroundColor: Colors.white,
              ),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: false,
              fontFamily: 'Urbanist',
            ),
            home: token == null ? CreateAccount() : BottomNav(),
          );
        });
  }
}
