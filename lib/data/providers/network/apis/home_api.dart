import 'dart:convert';

import 'package:doctorcare/app/util/AsyncStorage.dart';
import 'package:doctorcare/data/models/home/ListDoctorResponse.dart';
import 'package:doctorcare/data/providers/network/Api.dart';
import 'package:logger/logger.dart';

class HomeApi {
  static HomeApi? _instance;

  HomeApi._();

  factory HomeApi() => _instance ?? HomeApi._();

  final logger = Logger();
  AsyncStorage asyncStorage = AsyncStorage();

  Future<ListDoctorResponse> listDoctor() async {
    Api().dio.options.headers['Authorization'] =
        'Bearer ${asyncStorage.getToken()!}';
    var response = await Api().dio.get('/doctors');

    return ListDoctorResponse.fromJson(response.data);
  }
}
