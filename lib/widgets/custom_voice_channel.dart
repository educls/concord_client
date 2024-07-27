import 'dart:convert';

import 'package:concord_client/common_widget/round_button.dart';
import 'package:concord_client/controllers/channel_controller.dart';
import 'package:concord_client/controllers/web_socket_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/loading_controller.dart';
import '../controllers/server_controller.dart';
import '../entities/User_server.dart';

class VoiceChannelList extends StatefulWidget {
  @override
  State<VoiceChannelList> createState() => _VoiceChannelListState();
}

class _VoiceChannelListState extends State<VoiceChannelList> {
  final ServerController instServer = Get.find();
  final ChannelController instChannel = Get.put(ChannelController());
  final WebSocketController instWebSocket = Get.find();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Obx(() {
      if (instServer.instLoadTrue.isTrue.value || instServer.usersServer.isEmpty || instChannel.channelsServer.isEmpty || instChannel.channelsServer.first.id!.isEmpty) {
        return Container(
          color: Colors.black.withOpacity(0),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'CANAIS DE VOZ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Obx(() {
                    return SizedBox(
                      height: instChannel.channelsServer.fold(0, (sum, channel) => sum! + (channel.usersConected!.length * 50.0 + 50.0)),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: instChannel.channelsServer.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    instWebSocket.initializeAudioCapture();
                                    instWebSocket.connectOnChannel(instChannel.channelsServer[index].serverId!, index);
                                    instWebSocket.getUsersOnChannel(instChannel.channelsServer[index].id!, index);
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.volume_up,
                                            color: Colors.grey,
                                          ),
                                          Text(
                                            instChannel.channelsServer[index].name!,
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: instChannel.channelsServer[index].usersConected!.length * 50,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: instChannel.channelsServer[index].usersConected!.length,
                                  itemBuilder: (context, indexUsers) {
                                    return Obx(() {
          
                                      var user = instChannel.channelsServer[index].usersConected![indexUsers];
          
                                      late UserServer userServer = instServer.usersServer.firstWhere(
                                        (userServer) => userServer.userId == user.userId,
                                        // orElse: () => UserServer(photo: ''),
                                      );
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 40),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 18,
                                            backgroundImage: Image.memory(base64Decode(userServer.photo!)).image,
                                          ),
                                          title: Text(
                                            instChannel.channelsServer[index].usersConected![indexUsers].username!,
                                            style: const TextStyle(fontWeight: FontWeight.w600),
                                          ),
                                          trailing: instChannel.channelsServer[index].usersConected![indexUsers].userId == instServer.instUser.user.value.id
                                              ? IconButton(
                                                  onPressed: () {
                                                    instWebSocket.disconnectOnChannel(instChannel.channelsServer[index].serverId!, index);
                                                    // instServer.removeUserOnChannel(index, instServer.instUser.user.value.id!);
                                                  },
                                                  icon: const Icon(Icons.login_rounded))
                                              : null,
                                        ),
                                      );
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }),
                  instServer.instUser.user.value.id == instServer.server.value.ownerId
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              constraints: const BoxConstraints(minHeight: 40, minWidth: 100),
                              icon: const Icon(Icons.add),
                              style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color.fromARGB(45, 0, 0, 0))),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actions: [
                                        Container(
                                          decoration: const BoxDecoration(shape: BoxShape.rectangle),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  controller: instChannel.nameController,
                                                  decoration: const InputDecoration(
                                                    hintText: 'Digite o nome do canal',
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Text('Canal de Voz?'),
                                                    Obx(() {
                                                      return Checkbox(
                                                          value: instChannel.isVoice.value,
                                                          onChanged: (bool? value) {
                                                            instChannel.setIsVoice();
                                                          });
                                                    })
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: RoundButton(
                                                  width: 100,
                                                  title: 'Criar Canal',
                                                  onPressed: () {},
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            )
                          ],
                        )
                      : const SizedBox()
                ],
              ),
            ],
          ),
        );
      }
    });
  }
}
