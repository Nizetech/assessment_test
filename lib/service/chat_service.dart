// import 'dart:async';
// import 'dart:convert';
// // import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:assessment_test/constant/api_constant.dart';
// import 'package:assessment_test/provider/chat_provider.dart';
// import 'package:assessment_test/utils/app_logger.dart';
// import 'package:get/get.dart';
// import 'package:hive_flutter/adapters.dart';

// // import 'package:rxdart/rxdart.dart';
// // import 'package:socket_io_client/socket_io_client.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// // import 'package:web_socket_channel/io.dart';

// abstract class ChatService {
//   StreamController<String> get chatRoom;
//   void init();
//   void disposeSocket();
//   void sendMessage({required String message});
//   // void initiateChat({required String receiverId});
// }

// class ChatServiceImpl implements ChatService {
//   late Socket socket;
//   // IOWebSocketChannel channel;

//   final _log = appLogger(ChatServiceImpl);
//   Box box = Hive.box(kAppName);
//   // final ctrl = Get.put(ChatController());
//   // static const _message = "message";
//   //? LISTENING TO EVENTS FOR CHAT:

//   @override
//   void init() async {
//     final token = box.get('token');
//     log('initState');

//     Uri uri = Uri.parse("ws://api-assessment.meeney.com/ws/some_path/");
//     Uri uriWithToken = uri.replace(queryParameters: {'token': token});

//     .channel = IOWebSocketChannel.connect(uriWithToken, headers: {
//       'connection': 'upgrade',
//       'upgrade': 'websocket',
//     });

//     ctrl.channel.stream.listen((message) {
//       log('Connected: ${ctrl.channel.sink.done}');
//       print(message);
//     });
//   }

//   final StreamController<String> _chatRoom =
//       StreamController<String>.broadcast();

//   @override
//   StreamController<String> get chatRoom => _chatRoom;

//   List listChat = [];

//   Stream messageStream() {
//     return _chatRoom.stream;
//   }

//   // Send Message
//   @override
//   void sendMessage({
//     required String message,
//   }) {
//     ctrl.channel.stream.listen((message) {
//       ctrl.channel.sink.add(jsonEncode({
//         'type': 'message',
//         'message': message,
//       }));

//       log(message.toString());
//       ctrl.addMessage(jsonDecode(message));
//     });
//   }

//   List chat() {
//     return listChat;
//   }

//   @override
//   void disposeSocket() {
//     log("========== Destorying Go Live socket =========");
//     socket.clearListeners();
//     socket.close();
//     socket.disconnect();
//     socket.destroy();
//     socket.dispose();
//     // _chatRoom.close();
//     log("========== End Destory =========");
//   }
// }
