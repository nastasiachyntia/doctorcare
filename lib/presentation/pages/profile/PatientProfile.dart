import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class PatientProfile extends StatelessWidget {
  ColorIndex colorIndex = ColorIndex();
  HomePatientController homeController = Get.put(HomePatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          padding: EdgeInsets.all(16),
          child: Obx(
            () => homeController.isUserProfileLoading.value
                ? CircularProgressIndicator(
                    color: colorIndex.primary,
                  )
                : homeController.getBiodata(),
          ),
        ),
      ),
    );
  }
}
