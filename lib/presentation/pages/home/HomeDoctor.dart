import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/extentions/indexing/Illustrations.dart';
import 'package:doctorcare/presentation/controllers/home/HomeDoctorController.dart';
import 'package:doctorcare/presentation/pages/profile/DoctourProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class HomeDoctorScreen extends StatelessWidget {
  HomeDoctorController homeController = Get.put(HomeDoctorController());
  ColorIndex colorIndex = ColorIndex();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Obx(() => homeController.isUserProfileLoading.value
          ? Expanded(
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // App bar
                Container(
                  child: Stack(
                    children: [
                      Image.asset(AssetIndexing.homeSliverAppbar),
                      Column(children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    homeController
                                        .userProfile.value.data!.name!,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    color: Colors.grey),
                                child: InkWell(
                                  onTap: () =>
                                      {homeController.onSubmitLogoutDoctor()},
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Obx(
                                      () => homeController
                                              .isUserProfileLoading.value
                                          ? CircularProgressIndicator(
                                              color: colorIndex.primary,
                                            )
                                          : Image.network(
                                              homeController.userProfile.value
                                                          .data?.image !=
                                                      null
                                                  ? homeController.userProfile
                                                      .value.data!.image!
                                                  : 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      child: StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: [
                      StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: InkWell(
                            onTap: () =>
                                homeController.onNavigateToDoctorList(),
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colorIndex.secondary),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 6),
                                        child:
                                            Image.asset(AssetIndexing.surgeon),
                                      ),
                                    ),
                                    Text('Data Doctor')
                                  ],
                                ),
                              ),
                            ),
                          )),
                      StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: InkWell(
                            onTap: () => homeController.onNavigateToChatList(),
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colorIndex.secondary),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 6),
                                        child: Image.asset(
                                            AssetIndexing.doctorChat),
                                      ),
                                    ),
                                    const Text('Chat')
                                  ],
                                ),
                              ),
                            ),
                          )),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: InkWell(
                            onTap: () =>
                                homeController.onNavigateToHistoryDoctor(),
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colorIndex.secondary),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 6),
                                        child: Image.asset(
                                            AssetIndexing.doctorHistory),
                                      ),
                                    ),
                                    const Text('My History'),
                                  ],
                                ),
                              ),
                            )),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: InkWell(
                          onTap: () {
                            Get.to(() => DoctorProfile());
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: colorIndex.secondary),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 6),
                                      child: Image.asset(
                                          AssetIndexing.doctorProfile),
                                    ),
                                  ),
                                  const Text('Account')
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                )
              ],
            )),
    ));
  }
}
