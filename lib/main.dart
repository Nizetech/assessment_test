import 'package:assessment_test/auth/create_account.dart';
import 'package:assessment_test/bottom_nav.dart';
import 'package:assessment_test/constant/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

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
    String token = box.get('token');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Urbanist',
      ),
      home: token == '' ? CreateAccount() : BottomNav(),
    );
  }
}
