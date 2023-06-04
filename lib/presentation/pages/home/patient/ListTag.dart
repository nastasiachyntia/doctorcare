import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/util/Common.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ListTag extends StatelessWidget {
  HomePatientController homePatientController = Get.find();
  ColorIndex colorIndex = ColorIndex();
  var logger = Logger();

  Widget DoctorItem(String doctorID, String image, String name,
      String specialistName, String amount) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              homePatientController.navigateToDetailDoctor(doctorID);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.grey),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Obx(
                        () => homePatientController.isListDoctorsLoading.value
                            ? CircularProgressIndicator(
                                color: colorIndex.primary,
                              )
                            : Image.network(
                                image,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 36),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              specialistName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    Common.convertToIdr(
                        int.parse(Common.removeAfterPoint(amount)), 2),
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
        title: Text(homePatientController.selectedTag.value
            .replaceAll(RegExp(' \n'), ' ')),
      ),
      body: Obx(
        () => homePatientController.isListDoctorsLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : homePatientController.listDoctorSelectedTag.value.data!.length > 0
                ? ListView.builder(
                    itemCount: homePatientController
                        .listDoctorSelectedTag.value.data?.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return DoctorItem(
                          homePatientController
                              .listDoctorSelectedTag.value.data![index].code!,
                          homePatientController
                              .listDoctorSelectedTag.value.data![index].image!,
                          homePatientController
                              .listDoctorSelectedTag.value.data![index].name!,
                          homePatientController.listDoctorSelectedTag.value
                              .data![index].specialists!.name!,
                          homePatientController.listDoctorSelectedTag.value
                              .data![index].specialists!.amount!);
                    },
                  )
                : Container(
                    child: Center(
                      child: Text(
                        'No ' +
                            homePatientController.selectedTag.value
                                .replaceAll(RegExp(' \n'), ' ') +
                            ' doctors are available right now',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),textAlign: TextAlign.center,
                      ),
                    ),
                  ),
      ),
    );
  }
}
