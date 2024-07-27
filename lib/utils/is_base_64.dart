import 'dart:convert';

class IsBase64{
  final String base64;
  IsBase64({required this.base64});

  verify() {
    try {
      base64Decode(base64);
      return true;
    } catch (e) {
      return false;
    }
  }
}