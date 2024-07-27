import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey3 = GlobalKey<FormState>();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void login() {
    if (formKey3.currentState?.validate() ?? false) {
      // Implementar lógica de lembrar senha
      print("Email: ${emailController.text}");
    }
  }

  void goToLogin() {
    Get.toNamed('/login');
  }
}
