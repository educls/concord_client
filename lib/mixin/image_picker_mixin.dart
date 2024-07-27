import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/image_controller.dart';

mixin ImagePickerStateHelper<T extends StatefulWidget> on State<T> {

  final ImageController imageController = Get.find();

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
      imageController.photoBase64.value = base64Encode(bytes);
      imageController.image.value = Image.memory(bytes);
    } else {
      print('Nenhuma imagem foi selecionada.');
    }
  } catch (e) {
    print('Erro ao pegar a imagem: $e');
  }
}

}