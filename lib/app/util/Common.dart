import 'dart:convert';

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

}
