import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/data/models/Chat/ChatFirestore.dart';
import 'package:doctorcare/data/models/home/WidgetDoctor.dart';
import 'package:doctorcare/presentation/controllers/chat/ChatFirestoreController.dart';
import 'package:doctorcare/presentation/controllers/home/HomeDoctorController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ListHistoryByDoctor extends StatelessWidget {
  HomeDoctorController homeController = Get.find();
  ChatFirestoreController firestoreController = Get.find();
  ColorIndex colorIndex = ColorIndex();
  var logger = Logger();

  Widget HistoryItem(ChatFirestore? data) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              homeController.navigateToHistoryDetail(data!);
            },
            child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                            data!.image!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data!.doctorName!,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 17),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            data.date!.split('.')[0],
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                        ),
                        Text(
                          data.diagnose!,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.pink),
                        ),
                      ],
                    ),
                  ],
                )),
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
      body: SingleChildScrollView(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: firestoreController.historyByDoctorList.value.length,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return HistoryItem(
                firestoreController.historyByDoctorList.value[index]);
          },
        ),
      ),
    );
  }
}
