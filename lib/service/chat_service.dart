import 'dart:async';
// import 'dart:convert';
import 'dart:developer';

import 'package:assessment_test/constant/api_constant.dart';
import 'package:assessment_test/utils/app_logger.dart';
import 'package:hive_flutter/adapters.dart';

// import 'package:rxdart/rxdart.dart';
import 'package:socket_io_client/socket_io_client.dart';
// import 'package:web_socket_channel/io.dart';

abstract class ChatService {
  // StreamController<List<Message>> get chatRoom;
  void init();
  void disposeSocket();
  void sendMessage({required String message, required String roomId});
  void initiateChat({required String receiverId});
}

class ChatServiceImpl implements ChatService {
  // final WidgetRef ref;
  // ChatServiceImpl({Ref? ref}) : ref = WidgetRef;
  // final WidgetRef ref = locator();

  late Socket socket;
  // Ref ref = Ref();

  final _log = appLogger(ChatServiceImpl);
  Box box = Hive.box(kAppName);

  // final LocalCache? localCache = locator();

  //? EVENTS EMITTED
  static const _initiateChat = "chat:initiate";
  static const _sendMessage = "chat:message:new";

  //? LISTENING TO EVENTS FOR CHAT:
  // static const _initiateChatResponse = "response:chat:initiate";
  static const _message = "message";

  @override
  void init() {
    // final token = localCache!.getToken();
    // List<Message> messages = [];
    final token = box.get('token');

    // void addToExistingList(List<Message> event) {
    //   messages.addAll(event);
    // }

    socket = io(
        "ws://api-assessment.meeney.com/ws/some_path?token=$token",
        <String, dynamic>{
          'transports': ['websocket'],
          "forceNew": true,
          // 'extraHeaders': {
          //   'authorization': 'Bearer $token',
          // }
        });
    socket
      ..onConnect((_) {
        _log.i('Socket connected');
      })

      // //? LISTENING TO MESSAGES WHEN CHAT ROOM IS OPENED

      // //? LISTEN FOR INCOMING MESSAGES
      ..on(_message, (data) {
        _log.i('Incoming Chat Response');
        // ignore: avoid_dynamic_calls
        log(data.toString());

        // final chatData = data["data"]['message'] as Map<String, dynamic>;
        // log('===> $chatData');
        // final chatMessage = Message.fromJson(chatData as Map<String, dynamic>);

        /// ==== 3. Spread the existing messages and add the new message to the list
        // _chatRoom.sink.add([
        //   ...messages,
        //   chatMessage,
        // ]);
        //   _chatRoom.sink.add(messages..add(chatMessage));
        //    messages.add(chatMessage);
        // _chatRoom.sink.add(messages);
      })
      ..onConnectError(
        (data) {
          _log.i("== Connection Error ==");
          _log.i(data.toString());
        },
      )
      ..on("ERROR", (data) {
        _log.i("==  Socket error ==");
        _log.i(data.toString());
      })
      ..onDisconnect((_) => _log.i('Socket disconnected'))
      ..connect();
  }

  // initiate chat
  @override
  void initiateChat({
    required String receiverId,
  }) {
    if (socket.connected) {
      const userId = '6494945b9409b66db8653b77';
      //! Change the userId to recieverId this is just for testing
      final data = {'targetuser_id': userId};
      socket.emit(_initiateChat, data);
      _log.i('Chat initiated');
      log(data.toString());
    } else {
      socket.connect();
    }
  }

  // Send Message
  @override
  void sendMessage({
    required String roomId,
    required String message,
  }) {
    if (socket.connected) {
      final data = {
        'chat_room_id': roomId,
        'message': message,
      };
      socket.emit(_sendMessage, data);
      _log.i('Message Sent');
      log(data.toString());
    } else {
      socket.connect();
    }
  }

  // final StreamController<List<Message>> _chatRoom =
  //     StreamController<List<Message>>.broadcast();

  // @override
  // StreamController<List<Message>> get chatRoom => _chatRoom;

  // final BehaviorSubject<List<ChatRoomModel>> _chatRoom =
  //     BehaviorSubject.seeded([], onListen: () {
  //   log("========== Go Live socket started =========");
  // });

  // @override
  // BehaviorSubject<List<ChatRoomModel>> get chatRoom => _chatRoom;

  @override
  void disposeSocket() {
    log("========== Destorying Go Live socket =========");
    socket.clearListeners();
    socket.close();
    socket.disconnect();
    socket.destroy();
    socket.dispose();
    // _chatRoom.close();
    log("========== End Destory =========");
  }
}
