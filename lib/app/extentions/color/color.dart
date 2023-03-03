import 'package:flutter/material.dart';

class ColorIndex {
  final Color primary = HexColor('F50057');
  final Color disabled = HexColor('EBEBE4');
  final Color secondary = HexColor('FFD7E5');
  final Color lightBlue = HexColor('E5E7FF');
  final Color lightPink = HexColor('FFE9E9');
  final Color lightCyan = HexColor('DFF7FE');
  final Color lightGrey = HexColor('EFEFEF');
  final Color lightGreen = HexColor('D4FFE3');
  final Color lighterPink = HexColor('FFEBEB');
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
