import 'package:concord_client/common_widget/round_button.dart';
import 'package:concord_client/common_widget/round_textfield.dart';
import 'package:concord_client/controllers/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';
import 'custom_img_picker.dart';

class CustomCreateOrEnjoyServer extends StatelessWidget {
  CustomCreateOrEnjoyServer({super.key});
  final UserController userController = Get.find();
  final ServerController serverController = Get.find();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Builder(builder: (context) {
              return IconButton(
                iconSize: 50.0,
                icon: Obx(() {
                  return CircleAvatar(
                    radius: 35,
                    backgroundImage: userController.image.value.image,
                  );
                }),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            }),
          ],
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: media.height * 0.8,
                      decoration: const BoxDecoration(color: Color.fromARGB(255, 79, 137, 190)),
                      child: Center(
                        child: Column(
                          children: [
                            RoundTextField(
                              readOnly: false,
                              margin: EdgeInsets.only(
                                top: media.height * 0.3,
                                left: media.height * 0.2,
                                right: media.height * 0.2,
                                bottom: media.height * 0.06,
                              ),
                              controller: serverController.controlerInvite,
                              hitText: 'Invite Link',
                              icon: 'lib/assets/icons/invite_icon.png',
                            ),
                            RoundButton(
                              width: 200,
                              title: 'Join',
                              onPressed: serverController.joinAnServer,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: media.height * 0.8,
                      decoration: const BoxDecoration(color: Color.fromARGB(255, 79, 137, 190)),
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: media.height * 0.1),
                              child: const CustomImgPickerAvatar(),
                            ),
                            RoundTextField(
                              readOnly: false,
                              margin: EdgeInsets.only(
                                top: media.height * 0.05,
                                left: media.height * 0.2,
                                right: media.height * 0.2,
                                bottom: media.height * 0.06,
                              ),
                              controller: serverController.controllerName,
                              hitText: 'Name Server',
                              icon: 'lib/assets/icons/grupo_icon.png',
                            ),
                            RoundButton(
                              width: 200,
                              title: 'Create Server',
                              onPressed: serverController.createServer,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
