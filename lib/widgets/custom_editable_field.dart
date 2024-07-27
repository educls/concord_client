import 'package:concord_client/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/color_extension.dart';
import '../types/enum/edit_user_types.dart';

class CustomEditableField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final TypeEditUser type;
  final TextEditingController controller;
  const CustomEditableField({
    super.key,
    required this.label,
    required this.isPassword,
    required this.type,
    required this.controller,
  });

  @override
  State<StatefulWidget> createState() => _CustomEditableFieldState();
}

class _CustomEditableFieldState extends State<CustomEditableField> {
  final UserController instUser = Get.find();

  Rx<bool> isEditing = false.obs;

  void setEditingState(bool setEditing, TypeEditUser type) {
      isEditing.value = setEditing;
    if (!isEditing.value) {
      instUser.editUser(type);
    }
  }

  @override
  build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.label,
                          style: TextStyle(
                            color: TColor.lighBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 226, 226, 226),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      style: TextStyle(fontWeight: FontWeight.bold, color: isEditing.value ? Colors.black : Colors.black38),
                      controller: widget.controller,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(isEditing.value ? Icons.check : Icons.edit, color: Colors.grey),
                          onPressed: () {
                            setEditingState(!isEditing.value, widget.type);
                          },
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      obscureText: widget.isPassword ? !isEditing.value : widget.isPassword,
                      readOnly: !isEditing.value,
                    ),
                  ),
                );
              })
            ],
          );
        },
      ),
    );
  }
}
