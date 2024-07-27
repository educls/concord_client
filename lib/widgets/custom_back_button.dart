import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        label: const Text(
          'Voltar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17
          ),
        ),
      ),
    );
  }
}
