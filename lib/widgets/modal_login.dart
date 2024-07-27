import 'package:concord_client/common_widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/loading_controller.dart';
import '../controllers/login_controller.dart';

class ModalLogin extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  final LoadingController inst = Get.find();
  ModalLogin({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(media.width * 0.03),
      margin: EdgeInsets.symmetric(horizontal: media.width * 0.35, vertical: media.height * 0.27),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          colors: [Color.fromARGB(45, 255, 255, 255), Color.fromARGB(34, 255, 255, 255)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Form(
          key: controller.formKey2,
          child: Obx(() {
            if (inst.isLoading.value) {
              return Container(
                color: Colors.black.withOpacity(0),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: media.height * 0.025,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
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
                  // SizedBox(height: media.height * 0.02),
                  Expanded(
                    child: TextFormField(
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: media.height * 0.025,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira sua senha';
                        }
                        return null;
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: controller.goToForgotPassword,
                      child: Text(
                        'Esqueci minha senha',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: media.height * 0.017,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: media.height * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: RoundButton(
                          width: media.height * 0.2,
                          title: 'Login',
                          onPressed: controller.login,
                          fontSize: media.width * 0.011,
                        ),
                      ),
                      Expanded(
                        child: RoundButton(
                          width: media.height * 0.18,
                          title: 'Cadastre-se',
                          onPressed: controller.goToRegister,
                          fontSize: media.width * 0.011,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          })),
    );
  }
}
