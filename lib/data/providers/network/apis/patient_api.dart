import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorcare/app/util/AsyncStorage.dart';
import 'package:doctorcare/data/models/Patient/EditPatientRequest.dart';
import 'package:doctorcare/data/models/Patient/EditPatientResponse.dart';
import 'package:doctorcare/data/models/home/ListDoctorResponse.dart';
import 'package:doctorcare/data/models/home/ListSpecialistResponse.dart';
import 'package:doctorcare/data/models/home/UserProfileResponse.dart';
import 'package:doctorcare/data/providers/network/Api.dart';
import 'package:logger/logger.dart';

class PatientAPI {
  static PatientAPI? _instance;

  PatientAPI._();

  factory PatientAPI() => _instance ?? PatientAPI._();

  final logger = Logger();
  AsyncStorage asyncStorage = AsyncStorage();

  Future<EditPatientResponse> submitEditProfile(
      EditPatientRequest payload) async {
    var token = asyncStorage.getToken();

    FormData formData = FormData();

    var response;

    if (payload.isChangeImage!) {
      Api().dio.options.headers["Content-Type"] = "multipart/form-data";
      String fileName = payload.imageFile!.split('/').last;

      formData = FormData.fromMap({
        'address': payload.address?.trim(),
        'birthDate': payload.birthDate?.trim(),
        'birthPlace': payload.birthPlace?.trim(),
        'bloodType': payload.bloodType?.trim(),
        'gender': payload.gender?.trim(),
        'height': payload.height,
        'isMarriage': payload.isMarriage,
        'name': payload.name?.trim(),
        'weight': payload.weight,
        'image':
            await MultipartFile.fromFile(payload.imageFile!, filename: fileName)
      });

      response = await Api().dio.put('/profile/patient', data: formData);

      Api().dio.options.headers["Content-Type"] = Headers.jsonContentType;

      AlternateEditPatientRequest mapAlternate = AlternateEditPatientRequest(
        address: payload.address,
        birthDate: payload.birthDate,
        birthPlace: payload.birthPlace,
        bloodType: payload.bloodType,
        gender: payload.gender,
        height: payload.height,
        isMarriage: payload.isMarriage,
        name: payload.name,
        weight: payload.weight,
      );

      logger.e(formData.fields.toString());

      Api().dio.options.headers['Authorization'] = 'Bearer $token';

      response =
          await Api().dio.put('/profile/patient', data: mapAlternate.toJson());
    } else {
      AlternateEditPatientRequest mapAlternate = AlternateEditPatientRequest(
        address: payload.address,
        birthDate: payload.birthDate,
        birthPlace: payload.birthPlace,
        bloodType: payload.bloodType,
        gender: payload.gender,
        height: payload.height,
        isMarriage: payload.isMarriage,
        name: payload.name,
        weight: payload.weight,
      );

      logger.e(formData.fields.toString());

      Api().dio.options.headers['Authorization'] = 'Bearer $token';

      response =
          await Api().dio.put('/profile/patient', data: mapAlternate.toJson());
    }

    Api().dio.options.headers["Content-Type"] = Headers.jsonContentType;

    var resp = EditPatientResponse.fromJson(response.data);

    return resp;
  }
}
