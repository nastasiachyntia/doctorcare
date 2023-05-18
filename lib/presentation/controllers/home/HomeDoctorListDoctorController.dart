import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/presentation/controllers/home/HomeDoctorController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDoctorListDoctorController extends GetxController
    with GetSingleTickerProviderStateMixin {
  HomeDoctorController homeController = Get.find();
  ColorIndex colorIndex = ColorIndex();

  List<Tab> myTabs = <Tab>[
    const Tab(text: 'All Doctor'),
    const Tab(text: 'Specialist'),
  ];

  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: myTabs.length);
    asyncLoadTabs();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  void asyncLoadTabs({int index = 0}) async {
    await Future.delayed(Duration(seconds: 2), () {
      myTabs = [
        Tab(
          text: 'All Doctor',
          child: ListDoctor(),
        ),
        Tab(
          text: 'Specialist',
          child: ListSpecialist(),
        ),
      ];
      controller.dispose(); // release animation resources
      // recreate TabController as length is final/cannot change ↓
      controller = TabController(
          vsync: this,
          length: myTabs.length,
          initialIndex: index // to show a particular tab on create
      );
      update();
      // ↑ rebuilds GetBuilder widget with latest controller data
    });
  }

  Widget ListDoctor() {
    return ListView.builder(
      itemCount: homeController.listDoctors.value.data?.length,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return DoctorItem(
            homeController.listDoctors.value.data![index].code!,
            homeController.listDoctors.value.data![index].image!,
            homeController.listDoctors.value.data![index].name!,
            homeController.listDoctors.value.data![index].specialists!.name!,
            homeController.listDoctors.value.data![index].specialists!.amount!
        );
      },
    );
  }

  Widget ListSpecialist() {
    return ListView.builder(
      itemCount: homeController.listDoctors.value.data?.length,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return SpecialistItem(
            homeController.listSpecialist.value.data![index].code!.toString(),
            homeController.listSpecialist.value.data![index].image!,
            homeController.listSpecialist.value.data![index].name!,
            homeController.listSpecialist.value.data![index].code!,
            homeController.listSpecialist.value.data![index].description!
        );
      },
    );
  }

  Widget DoctorItem(String doctorID, String image, String name, String specialistName, String amount) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          InkWell(
            onTap: () {
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
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'Rp.${amount}',
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

  Widget SpecialistItem(String doctorID, String image, String name, String specialistName, String description) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          InkWell(
            onTap: () {
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
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
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

//    Widget ListDoctor() {
//     return ListView.builder(
//       itemCount: homeController.listDoctors.value.data?.length,
//       shrinkWrap: true,
//       itemBuilder: (_, index) {
//         return Container(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: Column(
//             children: [
//               InkWell(
//                 onTap: () {
//                   homeController.navigateToSuccessPayment();
//                 },
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: Row(
//                     children: [
//                       Container(
//                         height: 50,
//                         width: 50,
//                         decoration: const BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(50)),
//                             color: Colors.grey),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(50),
//                           child: Obx(
//                             () => homeController.isListDoctorsLoading.value
//                                 ? CircularProgressIndicator(
//                                     color: colorIndex.primary,
//                                   )
//                                 : Image.network(
//                                     homeController.listDoctors.value
//                                                 .data![index].image !=
//                                             null
//                                         ? homeController.listDoctors.value
//                                             .data![index].image!
//                                         : 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
//                                     fit: BoxFit.fill,
//                                   ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 36),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 homeController
//                                     .listDoctors.value.data![index].name!,
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.w700, fontSize: 17),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(vertical: 8),
//                                 child: Text(
//                                   homeController.listDoctors.value.data![index]
//                                       .specialists!.name!,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 14),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       Text(
//                         'Rp.${homeController.listDoctors.value.data![index].specialists!.amount!}',
//                         style: const TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 12,
//                             color: Colors.pink),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.symmetric(vertical: 5),
//                 child: const Divider(
//                     indent: 30, height: 10, endIndent: 30, thickness: 1),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
}
