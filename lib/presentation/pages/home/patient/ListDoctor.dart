import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/extentions/indexing/Illustrations.dart';
import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDoctors extends StatelessWidget {
  AssetIndexing assetIndexing = AssetIndexing();
  HomePatientController homeController = Get.find();
  ColorIndex colorIndex = ColorIndex();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.search_rounded),
              onPressed: () => {
                FToast().successToast('Still in Developmetn'),
              },
            )
          ],
          title: Text('List'),
        ),
        body: Obx(
          () => homeController.isListDoctorsLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: homeController.listDoctors.value.data?.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              homeController.navigateToSuccessPayment();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Colors.grey),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Obx(
                                        () => homeController
                                                .isListDoctorsLoading.value
                                            ? CircularProgressIndicator(
                                                color: colorIndex.primary,
                                              )
                                            : Image.network(
                                                homeController
                                                            .listDoctors
                                                            .value
                                                            .data![index]
                                                            .image !=
                                                        null
                                                    ? homeController
                                                        .listDoctors
                                                        .value
                                                        .data![index]
                                                        .image!
                                                    : 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 36),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            homeController.listDoctors.value
                                                .data![index].name!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text(
                                              homeController
                                                  .listDoctors
                                                  .value
                                                  .data![index]
                                                  .specialists!
                                                  .name!,
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
                                    'Rp.${homeController.listDoctors.value.data![index].specialists!.amount!}',
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
                                indent: 30,
                                height: 10,
                                endIndent: 30,
                                thickness: 3),
                          )
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
