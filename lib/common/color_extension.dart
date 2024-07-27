import 'package:flutter/material.dart';

class TColor {
  static Color get primaryColor1 => Color.fromARGB(255, 0, 51, 85);
  static Color get primaryColor2 => Color.fromARGB(255, 26, 73, 110);

  static Color get secondaryColor1 => const Color(0xffD4D3DD);
  static Color get secondaryColor2 => const Color(0xffD4D3DD);

  static List<Color> get primaryG => [primaryColor2, primaryColor1];
  static List<Color> get secondaryG => [secondaryColor2, secondaryColor1];

  static Color get black => const Color(0xff1D1617);
  static Color get gray => const Color(0xff786F72);
  static Color get white => Colors.white;
  static Color get lightGray => const Color(0xffF7F8F8);
//Paleta de cores academia start
  static Color get lighBlue => Color.fromRGBO(50, 56, 230, 1);
  static Color get blue => Color.fromRGBO(31, 35, 115, 1);
  static Color get darkBlue => Color.fromRGBO(17, 20, 64, 1);

  static Color get lighYellow => Color.fromRGBO(242, 214, 128, 1);
  static Color get darkYellow => Color.fromRGBO(242, 187, 19, 5);
}