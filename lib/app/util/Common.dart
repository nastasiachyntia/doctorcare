import 'dart:convert';

import 'package:intl/intl.dart';

class Common {
  static Common? _instance;

  Common._();

  factory Common() => _instance ?? Common._();

  bool canParseStringToInt(String param) {
    try {
      int.parse(param);
      return true;
    } catch (e) {
      return false;
    }
  }

  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  static String removeAfterPoint(String number) {
    return number.substring(0, number.indexOf('.'));
  }

  static String getFormattedName(String name){
    return name.replaceAll(' ', '-');
  }

  static String getChatRoomFormat(String patientName, String doctorName) {
    return "${getFormattedName(patientName)}_${getFormattedName(doctorName)}";
  }

}
