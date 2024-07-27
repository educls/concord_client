import 'dart:convert';

import 'package:concord_client/controllers/chat_controller.dart';
import 'package:concord_client/controllers/loading_controller.dart';
import 'package:concord_client/controllers/server_controller.dart';
import 'package:concord_client/utils/date_formater.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';
import '../entities/User_server.dart';

class CustomChat extends StatefulWidget {
  CustomChat({super.key});

  @override
  State<CustomChat> createState() => _CustomChatState();
}

class _CustomChatState extends State<CustomChat> {
  late ChatController instChat = Get.put(ChatController());

  late UserController instUser = Get.find();

  late LoadingController instLoad = Get.find();

  late ServerController instServer = Get.find();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: instLoad.isLoading.value || instChat.messagesFromDb.isEmpty || instServer.usersServer.isEmpty
                  ? Container(
                      color: Colors.black.withOpacity(0.1),
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      controller: instChat.scrollController,
                      itemCount: instChat.messages.length + instChat.messagesFromDb.length,
                      itemBuilder: (context, index) {
                        if (index < instChat.messagesFromDb.length) {
                          // print(instServer.usersServer);
                          UserServer user = instServer.usersServer.firstWhere((user) => user.userId == instChat.messagesFromDb[index].userId!);

                          // instChat.getUserPhoto(instChat.messagesFromDb[index].userId!);
                          bool isMyMessage = instChat.messagesFromDb[index].userId == instUser.user.value.id;
                          late Rx<Image> image = Image.memory(base64Decode(user.photo!)).obs;
                          return Padding(
                            padding: EdgeInsets.only(
                              left: isMyMessage ? 0.0 : 18.0,
                              right: isMyMessage ? 18.0 : 0.0,
                              top: 8.0,
                              bottom: 0.0,
                            ),
                            child: Row(
                              mainAxisAlignment: isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
                              children: [
                                Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            !isMyMessage
                                                ? CircleAvatar(
                                                    backgroundImage: image.value.image,
                                                    radius: media.width * 0.01,
                                                    backgroundColor: Colors.transparent,
                                                  )
                                                : const SizedBox(),
                                            const SizedBox(width: 5),
                                            SelectableText(
                                              (instChat.messagesFromDb[index].content!.length > 35)
                                                  ? instChat.messagesFromDb[index].content!.replaceAllMapped(
                                                      RegExp('.{1,35}'),
                                                      (Match match) => '${match.group(0)}\n',
                                                    )
                                                  : instChat.messagesFromDb[index].content!,
                                              style: const TextStyle(
                                                // Adicione a estilização desejada
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Text(
                                              '${DateFormatter().formatToDDMMYYYY(instChat.messagesFromDb[index].createdAt!)}\n${DateFormatter().getHourFromTimestamp(instChat.messagesFromDb[index].createdAt.toString())}',
                                              style: const TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                            (isMyMessage) ? const Icon(Icons.done) : const Text('')
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          int normalIndex = (index - instChat.messagesFromDb.length);
                          bool isMyMessage = instChat.messages[normalIndex].sender == instUser.user.value.id;

                          UserServer user = instServer.usersServer.firstWhere((user) => user.userId == instChat.messages[normalIndex].sender!);

                          late Rx<Image> image = Image.memory(base64Decode(user.photo!)).obs;
                          return Padding(
                            padding: EdgeInsets.only(
                              left: isMyMessage ? 0.0 : 18.0,
                              right: isMyMessage ? 18.0 : 0.0,
                              top: 8.0,
                              bottom: 0.0,
                            ),
                            child: Row(
                              mainAxisAlignment: isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
                              children: [
                                Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            !isMyMessage
                                                ? CircleAvatar(
                                                    backgroundImage: image.value.image,
                                                    radius: media.width * 0.01,
                                                    backgroundColor: Colors.transparent,
                                                  )
                                                : const SizedBox(),
                                            const SizedBox(width: 5),
                                            SelectableText(
                                              (instChat.messages[normalIndex].text!.length > 35)
                                                  ? instChat.messages[normalIndex].text!.replaceAllMapped(
                                                      RegExp('.{1,35}'),
                                                      (Match match) => '${match.group(0)}\n',
                                                    )
                                                  : instChat.messages[normalIndex].text!,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Text(
                                              '${DateFormatter().convertToDateTime(instChat.messages[normalIndex].timestamp!)}\n${DateFormatter().getHourFromTimestamp(instChat.messages[normalIndex].timestamp!)}',
                                              style: const TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                            (isMyMessage) ? const Icon(Icons.done) : const Text('')
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
            ),
          ),
          const Divider(),
          Container(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: instChat.textController,
                    decoration: const InputDecoration(
                      hintText: 'Digite sua mensagem...',
                    ),
                    onTap: () {},
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    instChat.sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
