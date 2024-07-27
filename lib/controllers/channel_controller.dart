import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../entities/Channels_server.dart';
import '../utils/request_api_class.dart';
import 'loading_controller.dart';
import 'package:http/http.dart' as http;

import 'server_controller.dart';
import 'user_controller.dart';

class ChannelController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  RxBool isVoice = false.obs;
  final UserController instUser = Get.find();
  final ServerController instServer = Get.find();
  final LoadingController load = Get.find();
  var channelsServer = <ChannelsServer>[].obs;

  @override
  void onInit() {
    getChannelsServer();
    super.onInit();
  }

  @override
  void onClose() {
    channelsServer.value = <ChannelsServer>[];
    super.onClose();
  }

  void setIsVoice() {
    isVoice.value = !isVoice.value;
  }

  void setNewUserOnChannel(int index, UsersConected user) {
    if (channelsServer.isNotEmpty) {
      print(channelsServer.first);
      channelsServer.first.usersConected!.add(user);
      channelsServer.refresh();
    }
  }

  void removeUserOnChannel(int index, String userId) {
    channelsServer[index].usersConected!.removeWhere((user) => user.userId == userId);
    channelsServer.refresh();
  }

  Future<void> getChannelsServer() async {
    http.Response response = await FetchApi(
      route: '/channels/get-channels-server',
      method: 'GET',
      authToken: jsonDecode(instUser.token),
      authServer: instServer.serverToken.value,
    ).fetch();
    if (response.statusCode == 200) {
      channelsServer.value = channelsServerFromJson(response.body);
      await Future.delayed(const Duration(milliseconds: 1000));
    }
    instServer.instLoadTrue.isTrue.value = false;
  }
}
