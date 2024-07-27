import 'dart:convert';
import 'dart:io';

import 'package:concord_client/types/enum/edit_user_types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/user_controller.dart';

mixin ImagePickerEditUserStateHelper<T extends StatefulWidget> on State<T> {

  final UserController instUser = Get.find();

  void pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  try {
    final pickedImage = await picker.pickImage(
      source: source,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (pickedImage != null) {
      final bytes = await File(pickedImage.path).readAsBytes();

      instUser.user.value.photo = base64Encode(bytes);

      instUser.image.value = Image.memory(bytes);
      instUser.editUser(TypeEditUser.photo);
    } else {
      print('Nenhuma imagem foi selecionada.');
    }
  } catch (e) {
    print('Erro ao pegar a imagem: $e');
  }
}

}