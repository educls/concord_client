import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../entities/user.dart';
import '../utils/request_api_class.dart';
import 'package:http/http.dart' as http;

import 'loading_controller.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey2 = GlobalKey<FormState>();
  LoadingController inst = Get.put(LoadingController());
  late String token = '';

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login() async {
    if (formKey2.currentState?.validate() ?? false) {
      inst.showLoading();
      
      await Future.delayed(const Duration(milliseconds: 1000));
      var user = User(
        email: emailController.text,
        password: passwordController.text,
      );
      http.Response response = await FetchApi(
        method: 'POST',
        route: '/login/authentication',
        body: jsonEncode(user),
      ).fetch();

      print("Email: ${emailController.text}, Senha: ${passwordController.text}");
      if (response.statusCode == 200) {
        goToHome();
        token = response.body;
        // print(token);
        // Get.snackbar(
        //   'Login Realizado',
        //   response.body,
        //   colorText: Colors.white,
        // );
      }
      if (response.statusCode != 200) {
        Get.snackbar(
          'Login não Realizado',
          response.body,
          colorText: Colors.white,
        );
      }
      await Future.delayed(const Duration(milliseconds: 500));
      inst.hideLoading();
    }
  }

  void goToForgotPassword() {
    Get.toNamed('/forgotPassword');
  }

  void goToRegister() {
    Get.toNamed('/register');
  }

  void goToHome() {
    Get.toNamed('/home');
  }
}
