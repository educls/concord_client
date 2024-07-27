import 'package:concord_client/common_widget/round_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/loading_controller.dart';
import '../controllers/register_controller.dart';
import 'custom_back_button.dart';
import 'custom_img_picker.dart';

class ModalRegister extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());
  final LoadingController inst = Get.find();
  ModalRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(media.width * 0.02),
      margin: EdgeInsets.symmetric(horizontal: media.width * 0.35, vertical: media.height * 0.2),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          colors: [Color.fromARGB(45, 255, 255, 255), Color.fromARGB(34, 255, 255, 255)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Form(
        key: controller.formKey1,
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
                const CustomBackButton(),
                const CustomImgPickerAvatar(),
                SizedBox(height: media.height * 0.02),
                Expanded(
                  child: TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.white,
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
                SizedBox(height: media.height * 0.02),
                Expanded(
                  child: TextFormField(
                    controller: controller.usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu username';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: media.height * 0.02),
                Expanded(
                  child: TextFormField(
                    controller: controller.passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      labelStyle: TextStyle(
                        color: Colors.white,
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
                SizedBox(height: media.height * 0.05),
                RoundButton(
                  width: media.width * 0.18,
                  title: 'Cadastre-se',
                  fontSize: media.width * 0.013,
                  onPressed: controller.register,
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
