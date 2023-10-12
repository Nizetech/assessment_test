import 'dart:convert';
import 'dart:developer';

import 'package:assessment_test/constant/api_constant.dart';
import 'package:assessment_test/provider/chat_provider.dart';
import 'package:assessment_test/service/chat_service.dart';
import 'package:assessment_test/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';

class ChatDm extends StatefulWidget {
  const ChatDm({super.key});

  @override
  State<ChatDm> createState() => _ChatDmState();
}

class _ChatDmState extends State<ChatDm> {
  final controller = TextEditingController();

  List<Map> messages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChatProvider chatProvider = Provider.of<ChatProvider>(context);
    chatProvider.init();

    print(chatProvider.messages);
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
        body: Consumer<ChatProvider>(
            // stream: context.read<ChatProvider>().channel.stream,
            builder: (context, snapShot, widget) {
          // if (snapShot.data == null) {
          //   return Center(
          //     child: Text('No messages Yet\n Type a message'),
          //   );
          // }
          print(snapShot.messages);
          //  jsonDecode(snapShot.data!);
          // messages.add(message);
          log('my Message =>$messages');
          print(messages.runtimeType);

          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            shrinkWrap: true,
            itemCount: messages.length,
            separatorBuilder: (_, index) => SizedBox(height: 40),
            itemBuilder: (_, index) {
              return Text(
                messages[index]['message'],
              );
              return Bubble(
                data: {},
                // messages[index],
              );
            },
          );
        }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 70,
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
                  child: Transform.translate(
                    offset: Offset(0, 7),
                    child: ChatField(
                      hintText: 'Type something',
                      controller: controller,
                    ),
                  ),
                ),
                SizedBox(width: 13),
                GestureDetector(
                  onTap: () {
                    // channel.sink.add(jsonEncode(
                    //   {
                    //     'type': 'message',
                    //     'message': controller.text,
                    //   },
                    // ));
                    chatProvider.sendMessage(message: controller.text);
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
