import 'dart:convert';

import 'package:concord_client/controllers/web_socket_controller.dart';
import 'package:concord_client/entities/Messages_saved_on_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../entities/Message.dart';
import '../entities/User_server.dart';
import '../utils/request_api_class.dart';
import 'loading_controller.dart';
import 'server_controller.dart';
import 'user_controller.dart';

class ChatController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  final WebSocketController instWebSocket = Get.find();
  final ServerController instServer = Get.find();
  final UserController instUser = Get.find();
  final LoadingController instLoad = Get.find();

  late RxList<MessageWebSocket> messages = <MessageWebSocket>[].obs;
  late RxList<MessageSavedOnDb> messagesFromDb = <MessageSavedOnDb>[].obs;

  late RxString base64photoUser = ''.obs;

  @override
  void onInit() {
    getMessagesFromDb();
    instServer.getUsersServer();
    super.onInit();
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void sendMessage() {
    instWebSocket.sendMessage(textController.text);
    textController.text = '';
  }

  void setNewMessage(MessageWebSocket message) {
    messages.add(message);
  }

  void getMessagesFromDb() async {
    http.Response response = await FetchApi(
      route: '/messages/get-messages-server',
      method: 'GET',
      authToken: jsonDecode(instUser.token),
      authServer: instServer.serverToken.value,
    ).fetch();
    if (response.statusCode == 200) {
      await Future.delayed(const Duration(milliseconds: 1000));
      messagesFromDb.value = messageSavedOnDbFromJson(response.body);
    }
  }

  void getUserPhoto(String userId) {
    UserServer user = instServer.usersServer.firstWhere(
      (user) => user.userId == userId,
      orElse: () => UserServer(userId: '', photo: ''),
    );
    base64photoUser.value = user.photo!;
  }
}
