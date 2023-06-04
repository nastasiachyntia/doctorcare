import 'dart:io';

import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/presentation/controllers/doctor/EditDoctorController.dart';
import 'package:doctorcare/presentation/controllers/home/HomeDoctorController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditDoctorProfile extends StatelessWidget {
  HomeDoctorController doctorController = Get.find();
  EditDoctorController editDoctorController = Get.put(EditDoctorController());

  ColorIndex colorIndex = ColorIndex();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Account'),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                    () =>
                editDoctorController.isPickedImage.value ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  height: 80,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      File(editDoctorController.pickedFile.value.path),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ) : Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  height: 80,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      editDoctorController.imageUrl.value != null
                          ? editDoctorController.imageUrl.value
                          : 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  editDoctorController.onPickImage();
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      'Change Picture',
                      style: TextStyle(
                        color: colorIndex.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: editDoctorController.nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorIndex.primary),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 3,
                  controller: editDoctorController.descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorIndex.primary),
                    ),
                  ),
                ),),
              TextField(
                controller: editDoctorController.experienceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Experienced (Years)',
                  labelStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorIndex.primary),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: editDoctorController.studyAtController,
                decoration: InputDecoration(
                  labelText: 'Study At',
                  labelStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorIndex.primary),
                  ),
                ),
              ),
              InkWell(
                onTap: () => editDoctorController.onSubmitEditPatient(),
                child: Container(
                  margin: EdgeInsets.only(top: 32),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  width: Get.width - 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: colorIndex.primary,
                  ),
                  child: const Text(
                    'SAVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
