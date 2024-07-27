import 'package:concord_client/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../mixin/img_picker_edit_user_mixin.dart';

class CustomImgPickerEditUser extends StatefulWidget {
  CustomImgPickerEditUser({super.key});

  @override
  State<CustomImgPickerEditUser> createState() => _CustomImgPickerEditUserState();
}

class _CustomImgPickerEditUserState extends State<CustomImgPickerEditUser> with ImagePickerEditUserStateHelper<CustomImgPickerEditUser> {
  final UserController instUser = Get.find();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Center(
        child: GestureDetector(
          onTap: () {
            pickImage(ImageSource.gallery);
          },
          child: Container(
            width: media.width * 0.087,
            height: media.height * 0.15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Obx(() {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: CircleAvatar(
                        backgroundImage: instUser.image.value.image,
                        minRadius: 0,
                      ),
                    );
                  }),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0.0, 1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: Colors.black.withOpacity(
                            0.2,
                          ),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: ImageIcon(
                        AssetImage('lib/assets/images/camera_tab.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}