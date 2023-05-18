import 'dart:convert';

import 'package:doctorcare/app/util/AsyncStorage.dart';
import 'package:doctorcare/data/models/home/DoctorDetailResponse.dart';
import 'package:doctorcare/data/models/home/DoctorUserProfileResponse.dart';
import 'package:doctorcare/data/models/home/ListDoctorResponse.dart';
import 'package:doctorcare/data/models/home/ListMedicalRecords.dart';
import 'package:doctorcare/data/models/home/ListSpecialistResponse.dart';
import 'package:doctorcare/data/models/home/UserProfileResponse.dart';
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

  Future<ListMedicalRecord> listHistory(String patientCode) async {
    Api().dio.options.headers['Authorization'] =
    'Bearer ${asyncStorage.getToken()!}';
    var response = await Api().dio.get('/medical-records/$patientCode');

    logger.i('List Medical Records : ${response.toString()}');

    return ListMedicalRecord.fromJson(response.data);
  }

  Future<DetailDoctorResponse> detailDoctor(String doctorID) async {
    Api().dio.options.headers['Authorization'] =
    'Bearer ${asyncStorage.getToken()!}';
    var response = await Api().dio.get('/doctors/$doctorID');

    logger.i('DETAIL DOCTOR $doctorID - ${response.toString()}');

    return DetailDoctorResponse.fromJson(response.data);
  }

  Future<ListSpecialistResponse> listSpecialist() async {
    Api().dio.options.headers['Authorization'] =
        'Bearer ${asyncStorage.getToken()!}';
    var response = await Api().dio.get('/specialists');

    return ListSpecialistResponse.fromJson(response.data);
  }

  Future<PatientUserProfileResponse> patientUserProfile() async {
    var token = asyncStorage.getToken();

    logger.i(token.toString());

    Api().dio.options.headers['Authorization'] =
    'Bearer $token';
    var response = await Api().dio.get('/profile/patient');

    return PatientUserProfileResponse.fromJson(response.data);
  }

  Future<DoctorUserProfileResponse> doctorUserProfile() async {
    var token = asyncStorage.getToken();

    logger.i(token.toString());

    Api().dio.options.headers['Authorization'] =
    'Bearer $token';
    var response = await Api().dio.get('/profile/doctor');

    return DoctorUserProfileResponse.fromJson(response.data);
  }


}
