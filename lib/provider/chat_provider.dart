import 'dart:convert';
import 'dart:developer';

import 'package:assessment_test/constant/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:web_socket_channel/io.dart';

class ChatProvider extends ChangeNotifier {
  ChatProvider() {
    init();
  }

  late IOWebSocketChannel channel;
  final controller = TextEditingController();
  List<Map> messages = [];
  Box box = Hive.box(kAppName);

  void addMessage(Map message) {
    messages.add(message);
    notifyListeners();
  }

  void init() async {
    final token = box.get('token');
    log('initState');

    Uri uri = Uri.parse("ws://api-assessment.meeney.com/ws/some_path/");
    Uri uriWithToken = uri.replace(queryParameters: {'token': token});

    channel = IOWebSocketChannel.connect(uriWithToken, headers: {
      'connection': 'upgrade',
      'upgrade': 'websocket',
    });

    channel.stream.listen((message) {
      log('Connected: ${channel.sink.done}');
      addMessage(jsonDecode(message));
      print(message);
    });
  }

  void sendMessage({
    required String message,
  }) {
    channel.sink.add(jsonEncode({
      'type': 'message',
      'message': message,
    }));
    controller.clear();
    addMessage({
      'message': message,
      'datetime': DateTime.now().toString(),
      'isMe': true,
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    controller.dispose();
    super.dispose();
  }
  // create a stream to listen to the messages
  // Stream<List<Map>> get messageStream => Stream.fromIterable([messages]);
}
