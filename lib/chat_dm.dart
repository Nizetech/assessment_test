import 'dart:developer';

import 'package:assessment_test/service/chat_service.dart';
import 'package:assessment_test/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDm extends StatefulWidget {
  const ChatDm({super.key});

  @override
  State<ChatDm> createState() => _ChatDmState();
}

class _ChatDmState extends State<ChatDm> {
  // List messages = [
  //   {
  //     'text': 'Hello, nice to have you here, how can i help?',
  //     'isSender': true,
  //     'time': '14:22',
  //   },
  //   {
  //     'text': 'I’ve made a payment and i’m yet to see it on my dashbaord.',
  //     'isSender': false,
  //     'time': '14:24',
  //   },
  //   {
  //     'text': 'Sorry about that give me some minutes to check your account.',
  //     'isSender': true,
  //     'time': '14:24',
  //   },
  //   {
  //     'text': 'Sure, i’ll be waiting',
  //     'isSender': false,
  //     'time': '14:30',
  //   },
  //   {
  //     'text':
  //         'Thanks for your patience, after checking your account we observed your transaction is already in progress, sorry for the delay.',
  //     'isSender': true,
  //     'time': '14:28',
  //   },
  // ];
  final controller = TextEditingController();

  List message = [];

  @override
  void initState() {
    ChatServiceImpl().init();
    message = ChatServiceImpl().chat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('my Message =>$message');
    return Scaffold(
      body: Scaffold(
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
            'Assessment Test',
            style: TextStyle(
              color: Color(0xFF434343),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          // elevation: 1,
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                Icons.more_vert_sharp,
              ),
            )
          ],
        ),
        body: StreamBuilder(
            stream: ChatServiceImpl().chatRoom.stream,
            builder: (context, snapShot) {
              if (snapShot.data == null) {
                return Center(
                  child: Text('No messages Yet\n Type a message'),
                );
              }
              final messages = snapShot.data!;
              log('my Message =>$messages');
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                shrinkWrap: true,
                itemCount: messages.length,
                separatorBuilder: (_, index) => SizedBox(height: 40),
                itemBuilder: (_, index) => Bubble(
                  data: {},
                  // messages[index],
                ),
              );
            }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 55,
                  width: 55,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF2676FC),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.asset('assets/attach_icon.png'),
                ),
                SizedBox(width: 13),
                Expanded(
                  child: SizedBox(
                    height: 70,
                    child: AppTextField(
                      hintText: 'Type something',
                      controller: controller,
                    ),
                  ),
                ),
                SizedBox(width: 13),
                GestureDetector(
                  onTap: () {
                    ChatServiceImpl().sendMessage(message: controller.text);
                    controller.clear();
                  },
                  child: Container(
                    height: 55,
                    width: 55,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFF2676FC),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Image.asset('assets/send_icon.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
