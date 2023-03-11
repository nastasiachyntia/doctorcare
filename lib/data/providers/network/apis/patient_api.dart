import 'dart:convert';

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

  Future<EditPatientResponse> submitEditProfile(EditPatientRequest payload) async {
    var token = asyncStorage.getToken();


    Api().dio.options.headers['Authorization'] =
    'Bearer $token';
    var response = await Api().dio.put('/profile/patient', data: jsonEncode(payload.toJson()));

    return EditPatientResponse.fromJson(response.data);
  }
}
