import 'dart:convert';

import 'package:concord_client/common_widget/round_textfield.dart';
import 'package:concord_client/entities/User_server_online.dart';
import 'package:concord_client/widgets/custom_voice_channel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/server_controller.dart';
import '../controllers/user_controller.dart';
import '../entities/User_server.dart';
import 'custom_chat.dart';

class CustomHomeServer extends StatelessWidget {
  CustomHomeServer({super.key});
  final UserController instUser = Get.put(UserController());
  late ServerController instServer = Get.find();
  Offset? tapPosition;
  Rx<double> volume = 0.5.obs;

  void storePosition(TapDownDetails details) {
    tapPosition = details.globalPosition;
  }

  void showCustomMenu(BuildContext context, Offset position, String id, String username, String role) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: [
        PopupMenuItem<int>(
          value: 1,
          child: ListTile(
            title: const Text('Perfil'),
            onTap: () {
            },
          ),
        ),
        PopupMenuItem<int>(
          value: 3,
          child: ListTile(
            title: const Text('Mensagem'),
            onTap: () {
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
            },
          ),
        ),
        PopupMenuItem<int>(
          value: 13,
          child: ListTile(
            title: const Text('Bloquear'),
            onTap: () {
            },
          ),
        ),
        instServer.server.value.ownerId == instUser.user.value.id
          ? PopupMenuItem<int>(
          value: 13,
          child: ListTile(
            title: Text(username.length > 10 ? 'Expulsar ${username.substring(0, 10)}...' : 'Expulsar $username'),
            onTap: () {
            },
          ),
        )
        : const PopupMenuItem<int>(child: null),
        
        PopupMenuItem<int>(
          value: 14,
          child: ListTile(
            title: const Text('Copiar ID do usuário'),
            trailing: const Icon(Icons.copy),
            onTap: () {
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    instServer.copyClipboardController.text = instServer.server.value.id!;
    return Column(
      children: [
        Row(
          children: [
            Builder(builder: (context) {
              return IconButton(
                iconSize: 50.0,
                icon: Obx(() {
                  return CircleAvatar(
                    radius: 40,
                    backgroundImage: instUser.image.value.image,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.green, width: 2),
                      ),
                    ),
                  );
                }),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            }),
            Expanded(
              child: Obx(() {
                return Stack(
                  children: [
                    SizedBox(
                      height: 85,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: instServer.usersServer.length,
                        itemBuilder: (context, index) {
                          UserServer user = instServer.usersServer[index];
                          if (user.userId != instUser.user.value.id) {
                            Rx<Image> image = Image.memory(base64Decode(user.photo!)).obs;
                            return IconButton(
                              onPressed: null,
                              iconSize: 50.0,
                              icon: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                                    child: GestureDetector(
                                      onTapDown: storePosition,
                                      onTap: () {
                                        showCustomMenu(context, tapPosition!, user.userId!, user.username!, user.role!);
                                      },
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: image.value.image,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: user.role == 'admin' ? Border.all(color: const Color.fromARGB(255, 145, 10, 0), width: 3) : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 3,
                                    right: 10,
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0.0, 1),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            color: Colors.black.withOpacity(0.2),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Obx(
                                          () => CircleAvatar(
                                            backgroundColor: instServer.usersOnline.any((userOnline) => userOnline.id == user.userId) ? const Color.fromARGB(255, 87, 255, 115) : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    left: 0,
                                    top: -6,
                                    child: Center(
                                      child: Text(
                                        user.username!.length > 6 ? '${user.username!.substring(0, 6)}...' : user.username!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
        Expanded(
          child: Row(
            children: [
              Container(
                width: 300,
                decoration: const BoxDecoration(color: Colors.grey),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: Image.memory(base64Decode(instServer.server.value.photo!)).image,
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Text(
                          instServer.server.value.name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    VoiceChannelList(),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RoundTextField(
                              margin: const EdgeInsets.only(left: 8, right: 8, top: 10),
                              readOnly: true,
                              hitText: '',
                              icon: 'lib/assets/icons/invite_icon.png',
                              controller: instServer.copyClipboardController,
                              rigtIcon: IconButton(
                                icon: const Icon(Icons.copy),
                                onPressed: instServer.copyToClipboard,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Color.fromARGB(255, 97, 96, 96)),
                  child: Center(
                    child: CustomChat(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
