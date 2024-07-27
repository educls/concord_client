import 'dart:convert';

import 'package:concord_client/controllers/image_controller.dart';
import 'package:concord_client/controllers/web_socket_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../entities/Server.dart';
import '../entities/User_server.dart';
import '../entities/User_server_online.dart';
import '../utils/request_api_class.dart';
import 'channel_controller.dart';
import 'loading_controller.dart';
import 'user_controller.dart';
import 'package:http/http.dart' as http;

class ServerController extends GetxController {
  final TextEditingController controlerInvite = TextEditingController();
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController copyClipboardController = TextEditingController();

  final LoadingController instLoadTrue = Get.put(LoadingController());

  final UserController instUser = Get.put(UserController());
  late ChannelController instChannels = Get.put(ChannelController());
  late WebSocketController instWebSocket = Get.put(WebSocketController());

  final LoadingController load = Get.find();
  final ImageController instImage = Get.put(ImageController());

  var serverToken = ''.obs;
  late Rx<Server> server = Server().obs;
  var usersServer = <UserServer>[].obs;
  var usersOnline = <UserServerOnline>[].obs;

  @override
  void onInit() async {
    super.onInit();
    getServerInfo();
  }

  @override
  void onClose() {
    usersServer.value = <UserServer>[];
    usersOnline.value = <UserServerOnline>[];
    super.onClose();
  }

  void setPhotoServer() {
    server.value.photo = instImage.photoBase64.value;
  }

  void setNomeServer(String name) {
    server.value.name = name;
  }

  Future<void> joinAnServer() async {
    load.showLoading();
    http.Response response = await FetchApi(
      route: '/servers/add-user-on-server/${controlerInvite.text}',
      method: 'POST',
      authToken: jsonDecode(instUser.token),
    ).fetch();
    await Future.delayed(const Duration(milliseconds: 1000));
    if (response.statusCode == 200 && response.body.length > 10) {
      await Future.delayed(const Duration(milliseconds: 1000));
      serverToken.value = jsonDecode(response.body);
      await getServerInfo();
      load.hideLoading();
    } else {
      showSnackBar('Invite', 'Invalid Invite', SnackPosition.BOTTOM);
      load.hideLoading();
    }
  }

  Future<void> createServer() async {
    load.showLoading();
    await Future.delayed(const Duration(milliseconds: 1000));
    if (controllerName.text.isEmpty || instImage.photoBase64.value.isEmpty) {
      showSnackBar('Fields', 'Fields are empty', SnackPosition.BOTTOM);
      load.hideLoading();
    }
    if (controllerName.text.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 1000));
      await FetchApi(
        route: '/servers/create-server',
        method: 'POST',
        authToken: jsonDecode(instUser.token),
        body: jsonEncode(
          {'name': controllerName.text, 'photo': instImage.photoBase64.value},
        ),
      ).fetch();
      await getServerInfo();
    }
  }

  Future<void> getServerInfo() async {
    load.showLoading();
    http.Response response = await FetchApi(
      route: '/servers/get-server-you-are-infos',
      method: 'GET',
      authToken: jsonDecode(instUser.token),
    ).fetch();

    if (response.statusCode == 200 && response.body.length > 10) {
      server.value = serverFromJson(response.body);
      await getTokenServer();
    }
  }

  Future<void> getTokenServer() async {
    http.Response response = await FetchApi(
      route: '/servers/get-user-token-on-server/${server.value.id}',
      method: 'GET',
      authToken: jsonDecode(instUser.token),
    ).fetch();
    if (response.statusCode == 200) {
      serverToken.value = jsonDecode(response.body);
      await getUsersServer();
      instWebSocket.connect();
    }
    load.hideLoading();
    // print(serverToken.value);
  }

  Future<void> getUsersServer() async {
    http.Response response = await FetchApi(
      route: '/servers/get-users-server/${server.value.id}',
      method: 'GET',
      authToken: jsonDecode(instUser.token),
    ).fetch();
    if (response.statusCode == 200) {
      usersServer.value = userServerFromJson(response.body);
    }
  }

  void showSnackBar(String title, String message, SnackPosition position) {
    Get.snackbar(
      backgroundColor: const Color.fromARGB(176, 80, 79, 79),
      snackPosition: position,
      title,
      message,
      colorText: Colors.white,
    );
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: copyClipboardController.text));
    showSnackBar('Texto Copiado', 'Código de Convite Copiado', SnackPosition.TOP);
  }
}
