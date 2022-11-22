import 'dart:convert';

import 'package:doctorcare/app/util/Common.dart';
import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/data/models/auth/RegisterRequest.dart';
import 'package:doctorcare/data/providers/network/apis/auth_api.dart';
import 'package:doctorcare/presentation/controllers/auth/RoleController.dart';
import 'package:doctorcare/presentation/pages/landing/Login.dart';
import 'package:doctorcare/presentation/pages/signup/SignUpPatient.dart';
import 'package:doctorcare/presentation/pages/signup/SuccessPatientRegistration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class PatientRegistrationController extends GetxController {
  var registrationPercentage = 0.5.obs;
  var currentRegistrationStep = 1.obs;

  RoleController roleController = Get.find();

  TextEditingController patientNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var isAgreeTermAndCondition = false.obs;

  var isFetching = false.obs;

  var obscurePassword = false.obs;
  var obscureConfirmPassword = false.obs;

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  late DateTime initialDateTime;

  var birthDate = ''.obs;

  late String selectedGender = 'notSelectedyet';
  final List<String> gender = ["Male", "Female"];
  final List<String> marriage = ["Married", "Single"];

  late String selectGender = 'false';
  late String selectMarriage = 'false';

  var selectedBloodGroup = 'A'.obs;
  var bloodGroupListType = <String>['A', 'B', 'AB', 'O'];

  var logger = Logger();

  @override
  void onInit() {
    super.onInit();
    initialDateTime = dateFormat.parse("1970-01-01");
    birthDateController.text = '1970-01-01';
  }

  bool checkStepOneForm() {
    if (patientNameController.value.text.trim().isEmpty) {
      FToast().warningToast('Please Input Patient Name!');

      return false;
    } else if (selectGender == 'false') {
      FToast().warningToast('Please Pick Patient Gender!');

      return false;
    } else if (selectMarriage == 'false') {
      FToast().warningToast('Please Pick Patient Marriage Status!');

      return false;
    } else if (addressController.value.text.trim().isEmpty) {
      FToast().warningToast('Please Input Patient Address');

      return false;
    }

    return true;
  }

  bool checkStepTwoForm() {
    if (weightController.value.text.trim().isEmpty) {
      FToast().warningToast('Please Input Patient Weight');

      return false;
    } else if (!weightController.value.text.isNum) {
      FToast().warningToast('Patient Weight format is invalid!');

      return false;
    } else if (heightController.value.text.trim().isEmpty) {
      FToast().warningToast('Please Input Patient Height');

      return false;
    } else if (!heightController.value.text.isNum) {
      FToast().warningToast('Patient Height format is invalid!');

      return false;
    } else if (emailController.value.text.trim().isEmpty) {
      FToast().warningToast('Please Input Patient Email');

      return false;
    } else if (!emailController.value.text.trim().isEmail) {
      FToast().warningToast('Email format is invalid!');

      return false;
    } else if (passwordController.value.text.trim().isEmpty) {
      FToast().warningToast('Please Input Account Password');

      return false;
    } else if (confirmPasswordController.value.text.trim().isEmpty) {
      FToast().warningToast('Please Input Password Confirmation');

      return false;
    } else if (confirmPasswordController.value.text.trim() !=
        passwordController.value.text.trim()) {
      FToast().warningToast('Password and Password Confirmation not match!');

      return false;
    }

    return true;
  }

  void onRegistrationSubmit() async {
    try {
      isFetching.value = true;
      update();

      final response = await AuthApi().registerPatient(RegisterRequest(
        address: addressController.value.text,
        birthDate: birthDateController.value.text,
        birthPlace: '-',
        bloodType: selectedBloodGroup.value,
        email: emailController.value.text,
        gender: selectGender == 'Male' ? 'L' : 'P',
        height: int.parse(heightController.value.text),
        isMarriage: selectMarriage == 'Single' ? 0 : 1,
        name: patientNameController.value.text,
        password: passwordController.value.text,
        weight: int.parse(weightController.value.text),
      ));

      logger.e(jsonEncode(response.toJson()));

      if (response.status == 'success') {
        Get.off(() => SuccessPatientRegistration());
      } else {
        FToast().warningToast(response.message);
      }
    } on Exception catch (e) {
      logger.e(e.toString());
      FToast().errorToast(e.toString());
    } finally {
      isFetching.value = false;
      update();
    }
  }

  void onButtonNextRegistrationPressed(BuildContext context) {
    if (!isFetching.value) {
      switch (currentRegistrationStep.value) {
        case 1:
          if (checkStepOneForm()) {
            currentRegistrationStep.value = currentRegistrationStep.value + 1;
            registrationPercentage.value = registrationPercentage.value + 0.5;
            update();
          }
          break;
        case 2:
          if (!checkStepTwoForm()) {
          } else if (isAgreeTermAndCondition.value) {
            onRegistrationSubmit();
          } else {
            showCupertinoModalPopup<void>(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                title: const Text('Information'),
                content: const Text(
                    'You must agree with our Term and Conditions and Privacy Policy to continue using Doctor Care'),
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                    isDestructiveAction: false,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
      }
    }
  }

  void onGoToMainMenuClicked() {
    Get.back();
    roleController.roleModal();
  }

  void onTermAndConditionPressed(bool value) {
    isAgreeTermAndCondition.value = value;
    update();
  }

  void onButtonBackRegistrationPressed() {
    switch (currentRegistrationStep.value) {
      case 1:
        roleController.onBackFromRegistrationPressed();
        update();
        break;
      case 2:
        currentRegistrationStep.value = currentRegistrationStep.value - 1;
        registrationPercentage.value = registrationPercentage.value - 0.5;
        update();
        break;
    }
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
}
