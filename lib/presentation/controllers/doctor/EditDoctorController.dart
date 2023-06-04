import 'dart:convert';

import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/data/models/Patient/EditPatientRequest.dart';
import 'package:doctorcare/data/models/home/UserProfileResponse.dart';
import 'package:doctorcare/data/providers/network/apis/home_api.dart';
import 'package:doctorcare/data/providers/network/apis/patient_api.dart';
import 'package:doctorcare/presentation/controllers/home/HomeDoctorController.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:doctorcare/presentation/pages/home/HomeDoctor.dart';
import 'package:doctorcare/presentation/pages/home/HomePatient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class EditDoctorController extends GetxController {
  var logger = new Logger();
  HomeDoctorController doctorContorller = Get.find();

  TextEditingController nameController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController studyAtController = TextEditingController();

  var imageUrl = ''.obs;

  final _picker = ImagePicker();

  var isPickedImage = false.obs;
  var pickedFile = PickedFile('').obs;

  @override
  void onReady() {
    super.onReady();

    nameController.text = doctorContorller.userProfile.value.data!.name!;
    experienceController.text =
        doctorContorller.userProfile.value.data!.experience!.toString();
    descriptionController.text =
        doctorContorller.userProfile.value.data!.description != null
            ? doctorContorller.userProfile.value.data!.description!
            : 'No Doctor Description';
    studyAtController.text = doctorContorller.userProfile.value.data!.studyAt!;
    imageUrl.value = doctorContorller.userProfile.value.data!.image!;

    update();
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
      EasyLoading.show();
      update();

      final response = await HomeApi().editDoctorUserProfile(
          nameController.text,
          experienceController.text,
          studyAtController.text,
          descriptionController.text,
          isPickedImage.value ? pickedFile.value.path : '',
          isPickedImage.value);

      if (response.status == 'success') {
        FToast().successToast(response.status!);

        doctorContorller.getUserProfile();

        Get.offAll(() => HomeDoctorScreen());
      } else {
        FToast().warningToast(response.message);
      }
    } on Exception catch (e) {
      FToast().errorToast(e.toString());
    } finally {
      update();
      EasyLoading.dismiss();
    }
  }
}
