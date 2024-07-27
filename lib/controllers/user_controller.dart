import 'dart:convert';

import 'package:concord_client/controllers/login_controller.dart';
import 'package:concord_client/controllers/web_socket_controller.dart';
import 'package:concord_client/utils/request_api_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../entities/user.dart';
import 'package:get/get.dart';

import '../types/enum/edit_user_types.dart';
import '../utils/is_base_64.dart';
import 'loading_controller.dart';

class UserController extends GetxController {
  late TextEditingController usernameController = TextEditingController(text: user.value.username);
  late TextEditingController emailController = TextEditingController(text: user.value.email);
  late TextEditingController passwordController = TextEditingController(text: user.value.password);
  final WebSocketController instWebSocket = Get.put(WebSocketController());
  final LoadingController load = Get.find();
  LoginController inst = Get.find();
  late Rx<Image> image;
  late String token = inst.token;
  late Rx<User> user = User().obs;

  @override
  void onInit() async {
    load.showLoading();
    super.onInit();
    http.Response response = await FetchApi(
      route: '/users/get-user-infos',
      method: 'GET',
      authToken: jsonDecode(token),
    ).fetch();
    if (response.statusCode == 200) {
      user.value = userFromJson(response.body);

      String? photoBase64 = user.value.photo;

      if (photoBase64 != '' && IsBase64(base64: photoBase64!).verify()) {
        image = Image.memory(base64Decode(photoBase64)).obs;
      } else {
        image = Image.asset('lib/assets/images/profile_tab.png').obs;
      }
    }

    // await Future.delayed(const Duration(milliseconds: 1000));
    load.hideLoading();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void editUser(TypeEditUser type) async {
    late String dataForFetch;
    switch (type) {
      case TypeEditUser.photo:
        dataForFetch = userToJson(User(photo: user.value.photo));
        break;
      case TypeEditUser.username:
        dataForFetch = userToJson(User(username: usernameController.text));
        break;
      case TypeEditUser.email:
        dataForFetch = userToJson(User(email: emailController.text));
        break;
      case TypeEditUser.password:
        dataForFetch = userToJson(User(password: passwordController.text));
        break;
      default:
    }
    await FetchApi(
      route: '/users/edit-user-infos',
      method: 'PUT',
      authToken: jsonDecode(token),
      body: dataForFetch,
    ).fetch();
    instWebSocket.updateUsers();
  }
}
