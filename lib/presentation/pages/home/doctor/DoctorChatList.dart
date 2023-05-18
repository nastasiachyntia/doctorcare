import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/util/Common.dart';
import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/presentation/controllers/chat/ChatFirestoreController.dart';
import 'package:doctorcare/presentation/controllers/home/HomeDoctorController.dart';
import 'package:doctorcare/presentation/controllers/home/HomeDoctorListDoctorController.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../controllers/home/HomePatientListDoctorController.dart';

class DoctorChatList extends StatelessWidget {
  HomeDoctorController homeController = Get.find();
  ChatFirestoreController chatFirestoreController = Get.find();
  ColorIndex colorIndex = ColorIndex();

  Widget ChatItem(String name, String image, String diagnose, String date, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              homeController.onNavigateToChat(
                  chatFirestoreController.historyByDoctorList.value[index]);
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
                              diagnose,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    date.split('1')[0],
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

  var logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: ListView.builder(
        itemCount: chatFirestoreController.historyByDoctorList.value.length,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return ChatItem(
              chatFirestoreController
                  .historyByDoctorList.value[index].patientName!,
              chatFirestoreController.historyByDoctorList.value[index].image!,
              chatFirestoreController.historyByDoctorList.value[index].diagnose!,
              chatFirestoreController.historyByDoctorList.value[index].date!,
              index);
        },
      ),
    );
  }
}
