import 'dart:convert';

import 'package:concord_client/controllers/image_controller.dart';
import 'package:concord_client/controllers/loading_controller.dart';
import 'package:concord_client/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/request_api_class.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  LoadingController inst = Get.find();
  ImageController instImagePicker = Get.put(ImageController());
  late Rx<String> photoBase64 = ''.obs;

  late Rx<Image> image;

  @override
  void onClose() {
    super.onClose();
  }

  void setBase64Image() {
    photoBase64 = instImagePicker.photoBase64;
  }

  void register() async {
    if (formKey1.currentState?.validate() ?? false) {
      inst.showLoading();
      await Future.delayed(const Duration(milliseconds: 1000));
      setBase64Image();
      var user = User(
        photo: photoBase64.value,
        email: emailController.text,
        username: usernameController.text,
        password: passwordController.text,
      );
      http.Response response = await FetchApi(
        method: 'POST',
        route: '/users/create-user',
        body: jsonEncode(user),
      ).fetch();
      print(response.body);

      // print("Email: ${emailController.text}, Senha: ${passwordController.text}");
      inst.hideLoading();
      if (response.statusCode == 200) {
        goToLogin();
        Get.snackbar(
          'Cadastro Realizado Com Sucesso',
          response.body,
          colorText: Colors.white,
        );
      }
      if (response.statusCode != 200) {
        Get.snackbar(
          'Cadastro não Realizado',
          response.body,
          colorText: Colors.white,
        );
      }
    }
  }

  void goToLogin() {
    Get.back();
  }
}
