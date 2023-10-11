import 'package:assessment_test/chat_dm.dart';
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
        title: const Text(
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
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                hintText: 'Search messages',
                prefixIcon: Transform.scale(
                  scale: .5,
                  child: Image.asset('assets/search_icon.png'),
                ),
                hintStyle: const TextStyle(
                  color: Color(0xFF434343),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 65),
            Material(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => Get.to(ChatDm()),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xfffebf10),
                      ),
                      SizedBox(width: 28),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Assessment Test',
                                  style: TextStyle(
                                    color: Color(0xFF434343),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '18/08/2023',
                                  style: TextStyle(
                                    color: Color(0xFF7D7F88),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 2),
                            Text(
                              'How much does it cost?',
                              style: TextStyle(
                                color: Color(0xFF434343),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}
