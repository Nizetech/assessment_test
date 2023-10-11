import 'package:assessment_test/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Transform.scale(
          scale: .5,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Image.asset(
              'assets/back_icon.png',
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Chat',
          style: TextStyle(
            color: Color(0xFF434343),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: 'Search messages',
                prefixIcon: Transform.scale(
                  scale: .5,
                  child: Image.asset('assets/search_icon.png'),
                ),
                hintStyle: TextStyle(
                  color: Color(0xFF434343),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
