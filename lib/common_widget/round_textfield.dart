import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/color_extension.dart';

class RoundTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hitText;
  final String icon;
  final Widget? rigtIcon;
  final bool obscureText;
  final EdgeInsets? margin;
  final String? Function(String?)? validator;
  final Function? setPassword;
  final TextInputFormatter? formatter;
  final bool readOnly;

  const RoundTextField(
      {super.key,
      required this.hitText,
      required this.icon,
      this.controller,
      this.margin,
      this.keyboardType,
      this.obscureText = false,
      this.rigtIcon,
      this.validator,
      this.setPassword,
      required this.readOnly,
      this.formatter});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(color: TColor.lightGray, borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        readOnly: readOnly,
        inputFormatters: formatter != null
            ? [
                FilteringTextInputFormatter.digitsOnly,
                formatter!,
              ]
            : null,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        onChanged: setPassword != null
            ? (value) {
                setPassword!(value);
              }
            : null,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hitText,
            suffixIcon: rigtIcon,
            prefixIcon: Container(
                alignment: Alignment.center,
                width: 40,
                height: 40,
                child: Image.asset(
                  icon,
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                  color: TColor.gray,
                )),
            hintStyle: TextStyle(color: TColor.gray, fontSize: 12)),
      ),
    );
  }
}
