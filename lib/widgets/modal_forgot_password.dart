import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widget/round_button.dart';
import '../controllers/forgot_password_controller.dart';
import 'custom_back_button.dart';

class ModalForgotPassword extends StatelessWidget {
  final ForgotPasswordController controller = Get.put(ForgotPasswordController());
  ModalForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(media.width * 0.03),
      margin: EdgeInsets.symmetric(horizontal: media.width * 0.35, vertical: media.height * 0.33),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          colors: [Color.fromARGB(45, 255, 255, 255), Color.fromARGB(34, 255, 255, 255)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Form(
        key: controller.formKey3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomBackButton(),
            SizedBox(height: media.height * 0.02),
            Expanded(
              child: TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: media.height * 0.022,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor, insira um email válido';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: media.height * 0.05),
            RoundButton(
              width: 200,
              title: 'Enviar',
              onPressed: controller.login,
            ),
          ],
        ),
      ),
    );
  }
}
