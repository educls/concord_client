import 'package:concord_client/controllers/user_controller.dart';
import 'package:concord_client/controllers/web_socket_controller.dart';
import 'package:concord_client/types/enum/edit_user_types.dart';
import 'package:concord_client/widgets/custom_editable_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_img_picker_edit_user.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  final UserController inst = Get.find();
  late WebSocketController instWebSocket = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 400,
      child: Column(
        children: [
          Obx(() {
            return SizedBox(
              height: 100,
              width: 400,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  '${inst.user.value.username}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            );
          }),
          const Padding(
            padding: EdgeInsets.all(0),
            child: Center(
              child: Text(
                'Edição de Perfil',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
            ),
          ),
          CustomImgPickerEditUser(),
          CustomEditableField(
            label: 'Username',
            isPassword: false,
            type: TypeEditUser.username,
            controller: inst.usernameController,
          ),
          CustomEditableField(
            label: 'Email',
            isPassword: false,
            type: TypeEditUser.email,
            controller: inst.emailController,
          ),
          CustomEditableField(
            label: 'Password',
            isPassword: true,
            type: TypeEditUser.password,
            controller: inst.passwordController,
          ),
          const Spacer(),
          ListTile(
            title: const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
            trailing: const Icon(Icons.logout),
            iconColor: Colors.red,
            onTap: () {
              instWebSocket.disconnect();
              Get.back();
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
