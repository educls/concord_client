import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/is_base_64.dart';

class ImageController extends GetxController {
  late Rx<Image> image;
  late Rx<String> photoBase64 = ''.obs;

  @override
  void onInit() {
    super.onInit();

    if (photoBase64.value != '' && IsBase64(base64: photoBase64.value).verify()) {
      image = Image.memory(base64Decode(photoBase64.value)).obs;
    } else {
      image = Image.asset('lib/assets/images/profile_tab.png').obs;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}