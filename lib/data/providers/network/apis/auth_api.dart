import 'dart:convert';

import 'package:doctorcare/data/models/auth/LoginRequest.dart';
import 'package:doctorcare/data/models/auth/LoginResponse.dart';
import 'package:doctorcare/data/models/auth/RegisterRequest.dart';
import 'package:doctorcare/data/models/auth/RegisterResponse.dart';
import 'package:doctorcare/data/providers/network/Api.dart';
import 'package:logger/logger.dart';

class AuthApi {
  static AuthApi? _instance;

  AuthApi._();

  factory AuthApi() => _instance ?? AuthApi._();

  final logger = Logger();

  Future<RegisterResponse> registerPatient(RegisterRequest payload) async {
    var response = await Api()
        .dio
        .post('/patients/register', data: jsonEncode(payload.toJson()));

    return RegisterResponse.fromJson(response.data);
  }

  Future<LoginResponse> loginPatient(LoginRequest payload) async {
    var response =
        await Api().dio.post('/login', data: jsonEncode(payload.toJson()));

    return LoginResponse.fromJson(response.data);
  }

  Future<LoginResponse> loginDoctor(LoginRequest payload) async {
    var response =
        await Api().dio.post('/login', data: jsonEncode(payload.toJson()));

    return LoginResponse.fromJson(response.data);
  }
}
