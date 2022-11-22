import 'dart:convert';

import 'package:doctorcare/data/models/auth/LoginResponse.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class AsyncStorage {
  final box = GetStorage();
  var logger = Logger();

  bool isLoginState() {
    var response = box.read('login');

    if (response != null) {
      return true;
    }
    return false;
  }

  String isLoggedIn() {
    if (isLoginState()) {
      logger.e(isLoggedInAsDoctor());
      if (isLoggedInAsDoctor()) {
        return 'doctor';
      }
      return 'patient';
    }

    return '';
  }

  void saveLoginState(LoginResponse response) async {
    await box.write('login', jsonEncode(response));
  }

  void setIsLoggedInAsDoctor(bool val) async {
    await box.write('isDoctor', val);
  }

  bool isLoggedInAsDoctor() {
    return box.read('isDoctor') ?? false;
  }

  String? getToken() {
    return box.read('token');
  }

  void saveToken(String value) async {
    await box.write('token', value);
  }

  Future<void> cleanLoginState() async {
    await box.write('login', null);
    await box.write('token', '');
  }
}
