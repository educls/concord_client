import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialogBasedClickMouse extends StatelessWidget {
  final Offset? position;
  final String? username;
  final String? role;
  final String? id;

  CustomDialogBasedClickMouse({
    this.position,
    this.id,
    this.role,
    this.username,
  });

  Rx<double> volume = 0.5.obs;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: (int result) {
        // Handle item selection if needed
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: 1,
          child: ListTile(
            title: const Text('Perfil'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem<int>(
          value: 3,
          child: ListTile(
            title: const Text('Mensagem'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem<int>(
          value: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Volume do usuário'),
              Obx(() {
                return Slider(
                  value: volume.value,
                  onChanged: (value) {
                    volume.value = value;
                  },
                );
              })
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Silenciar'),
              Checkbox(value: false, onChanged: (bool? value) {}),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 12,
          child: ListTile(
            title: const Text('Adicionar amigo'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem<int>(
          value: 13,
          child: ListTile(
            title: const Text('Bloquear'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem<int>(
          value: 14,
          child: ListTile(
            title: const Text('Copiar ID do usuário'),
            trailing: const Icon(Icons.copy),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ),
      ]
    );
  }
}
