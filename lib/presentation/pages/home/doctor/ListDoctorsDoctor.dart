import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/util/Common.dart';
import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/presentation/controllers/home/HomeDoctorController.dart';
import 'package:doctorcare/presentation/controllers/home/HomeDoctorListDoctorController.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../controllers/home/HomePatientListDoctorController.dart';

class ListDoctorsDoctor extends StatelessWidget {
  HomeDoctorController homeController = Get.find();
  ColorIndex colorIndex = ColorIndex();
  final HomeDoctorListDoctorController _tabx =
      Get.put(HomeDoctorListDoctorController());

  Widget DoctorItem(String doctorID, String image, String name,
      String specialistName, String amount) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          InkWell(
            onTap: () {},
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
                        () => homeController.isListDoctorsLoading.value
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
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_horiz_rounded),
                  ),
                  // Text(
                  //   Common.convertToIdr(
                  //       int.parse(Common.removeAfterPoint(amount)), 2),
                  //   style: const TextStyle(
                  //       fontWeight: FontWeight.w400,
                  //       fontSize: 12,
                  //       color: Colors.pink),
                  // ),
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

  var logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // IconButton(
          //   icon: Icon(Icons.search_rounded),
          //   onPressed: () => {
          //     FToast().successToast('Still in Development'),
          //   },
          // )
        ],
        title: Text('Data Doctor'),
      ),
      body: Obx(
        () => homeController.isListDoctorsLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                controller: _tabx.controller,
                children: _tabx.myTabs.map((Tab tab) {
                  return ListView.builder(
                    itemCount: homeController.listDoctors.value.data?.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return DoctorItem(
                          homeController.listDoctors.value.data![index].code!,
                          homeController.listDoctors.value.data![index].image!,
                          homeController.listDoctors.value.data![index].name!,
                          homeController.listDoctors.value.data![index]
                              .specialists!.name!,
                          homeController.listDoctors.value.data![index]
                              .specialists!.amount!);
                    },
                  );
                }).toList(),
              ),
      ),
    );
  }
}
