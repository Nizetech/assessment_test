
import 'package:assessment_test/provider/chat_provider.dart';
import 'package:assessment_test/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ChatDm extends StatefulWidget {
  const ChatDm({super.key});

  @override
  State<ChatDm> createState() => _ChatDmState();
}

class _ChatDmState extends State<ChatDm> {
  late ChatProvider chatProvider;
  List<Map> messages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    chatProvider = Provider.of<ChatProvider>(context);
    messages = chatProvider.messages;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(messages.length);
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
          title: const Text(
            'Assessment Test',
            style: TextStyle(
              color: Color(0xFF434343),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
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
        body: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          shrinkWrap: true,
          itemCount: messages.length,
          separatorBuilder: (_, index) => SizedBox(height: 40),
          itemBuilder: (_, index) {
            return Bubble(
              data: messages[index],
            );
          },
        ),
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
                      controller: chatProvider.controller,
                    ),
                  ),
                ),
                SizedBox(width: 13),
                GestureDetector(
                  onTap: () {
                    chatProvider.sendMessage(
                        message: chatProvider.controller.text);
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
