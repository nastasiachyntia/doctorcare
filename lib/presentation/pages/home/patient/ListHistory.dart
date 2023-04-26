import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/data/models/home/ListMedicalRecords.dart';
import 'package:doctorcare/data/models/home/WidgetDoctor.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../controllers/home/HomePatientListDoctorController.dart';

class ListHistory extends StatelessWidget {
  HomePatientController homeController = Get.find();
  ColorIndex colorIndex = ColorIndex();
  var logger = Logger();

  Widget HistoryItem(MedicalRecords? data) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data!.doctorCode!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 17),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      data.createdAt!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ),
                  Text(
                    data.diagnosis!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.pink),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: const Divider(
                indent: 30, height: 10, endIndent: 30, thickness: 1),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Obx(() => patientController.isListHistoryLoading.value || patientController.listMedicalRecord.value.data == null
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : SingleChildScrollView(
              child: ListView.builder(
                itemCount: homeController
                    .listMedicalRecord.value.data?.medicalRecords?.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return HistoryItem(homeController
                      .listMedicalRecord.value.data?.medicalRecords![index]);
                },
              ),
            )),
    );
  }
}
