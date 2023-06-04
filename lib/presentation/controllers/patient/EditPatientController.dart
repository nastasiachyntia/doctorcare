import 'dart:convert';

import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/data/models/Patient/EditPatientRequest.dart';
import 'package:doctorcare/data/models/home/UserProfileResponse.dart';
import 'package:doctorcare/data/providers/network/apis/patient_api.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:doctorcare/presentation/pages/home/HomePatient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class EditPatientController extends GetxController {
  var logger = new Logger();
  HomePatientController patientController = Get.find();

  TextEditingController patientNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var obscurePassword = false.obs;
  var obscureConfirmPassword = false.obs;

  var isFetching = false.obs;

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  DateFormat dateFormatFromAPI = DateFormat("MMM DD yyyy");
  DateFormat dateFormatForAPI = DateFormat("MMM DD yyyy");
  late DateTime initialDateTime;

  var birthDate = ''.obs;

  late String selectedGender = 'notSelectedyet';
  final List<String> gender = ["Male", "Female"];
  final List<String> marriage = ["Married", "Single"];

  late String selectGender = 'false';
  late String selectMarriage = 'false';

  var selectedBloodGroup = 'A'.obs;
  var bloodGroupListType = <String>['A', 'B', 'AB', 'O'];

  var imageUrl = ''.obs;

  final _picker = ImagePicker();

  var isPickedImage = false.obs;
  var pickedFile = PickedFile('').obs;

  @override
  void onReady() {
    super.onReady();

    patientNameController.text =
        patientController.userProfile.value.data!.name!;
    addressController.text = patientController.userProfile.value.data!.address!;
    weightController.text =
        patientController.userProfile.value.data!.weight!.toString();
    heightController.text =
        patientController.userProfile.value.data!.height!.toString();
    emailController.text = patientController.userProfile.value.data!.email!;
    imageUrl.value = patientController.userProfile.value.data!.image!;

    onClickGenderRadioButton(
        patientController.userProfile.value.data!.gender == 'L'
            ? 'Male'
            : 'Female');
    onClickMarriageRadioButton(
        patientController.userProfile.value.data!.isMarriage == 1
            ? 'Married'
            : 'Single');

    if (patientController.userProfile.value.data!.bloodType! == 'un') {
      onSelectedBloodGroup('O');
    } else {
      onSelectedBloodGroup(
          patientController.userProfile.value.data!.bloodType!);
    }

    passwordController.text = '111111';
    confirmPasswordController.text = '111111';

    String formattedCurrentBirthday = '';

    if (patientController.userProfile.value.data!.birthDate! ==
        'Invalid Date') {
      formattedCurrentBirthday =
          changeResponseFormat(dateFormat.parse("1970-01-01").toString());
    } else {
      String removedDay = patientController.userProfile.value.data!.birthDate!.substring(4, patientController.userProfile.value.data!.birthDate!.length);
      formattedCurrentBirthday = changeAPIResponseFormat(removedDay);
    }

    birthDateController.text = formattedCurrentBirthday;

    isPickedImage.value = false;

    update();

  }

  String changeAPIResponseFormat(String value) {
    DateTime dateTime = dateFormatFromAPI.parse(value);
    initialDateTime = dateTime;

    update();

    return dateTime.toString().substring(0, 10);
  }

  String changeResponseFormat(String value) {
    DateTime dateTime = dateFormat.parse(value);
    initialDateTime = dateTime;

    update();

    return dateTime.toString().substring(0, 10);
  }

  void onSelectedBloodGroup(String value) {
    selectedBloodGroup.value = value;
    update();
  }

  void onClickGenderRadioButton(value) {
    selectGender = value;
    update();
  }

  void onClickMarriageRadioButton(value) {
    selectMarriage = value;
    update();
  }

  void onTapPasswordObscure() {
    obscurePassword.value = !obscurePassword.value;
    update();
  }

  void onTapConfirmPasswordObscure() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
    update();
  }

  void onBirthDateSelected(DateTime newTime) {
    birthDate.value = DateFormat('yyyy-MM-dd').format(newTime);
    birthDateController.text = birthDate.value;
  }

  void onPickImage() async {
    final PickedFile? _pickedFile =
        await _picker.getImage(source: ImageSource.camera);
    pickedFile.value = _pickedFile!;
    isPickedImage.value = true;

    update();
  }

  void onSubmitEditPatient() async {
    try {
      isFetching.value = true;
      update();

      var payload = EditPatientRequest(
        address: addressController.value.text,
        birthDate: birthDateController.value.text,
        birthPlace: '-',
        bloodType: selectedBloodGroup.value,
        gender: selectGender == 'Male' ? 'L' : 'P',
        height: int.parse(heightController.value.text),
        isMarriage: selectMarriage == 'Single' ? 0 : 1,
        name: patientNameController.value.text,
        weight: int.parse(weightController.value.text),
        imageFile: isPickedImage.value ? pickedFile.value.path : '',
        isChangeImage: isPickedImage.value,
      );

      final response = await PatientAPI().submitEditProfile(payload);

      if (response.status == 'success') {
        FToast().warningToast(response.status);

        patientController.getUserProfile();

        Get.offAll(() => HomePatientScreen());
      } else {
        FToast().warningToast(response.message);
      }
    } on Exception catch (e) {
      FToast().errorToast(e.toString());
    } finally {
      isFetching.value = false;
      update();
    }
  }
}
