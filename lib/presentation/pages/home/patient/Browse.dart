import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/extentions/indexing/Illustrations.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class Browse extends StatelessWidget{
  AssetIndexing assetIndexing = AssetIndexing();
  HomePatientController homeController = Get.put(HomePatientController());
  ColorIndex colorIndex = ColorIndex();

  Widget widgetStaggered() {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: [
        // ...?generateDoctorsWidget(homeController.listDoctors.value)
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 4,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.pinkAccent.withOpacity(0.4)),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.8)),
                    width: 64,
                    height: 64,
                  ),
                  Text('Dermatologist')
                ],
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orangeAccent.withOpacity(0.4)),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.8)),
                    width: 64,
                    height: 64,
                  ),
                  const Text('Pediatric')
                ],
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent.withOpacity(0.4)),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.8)),
                    width: 64,
                    height: 64,
                  ),
                  const Text('Surgeon'),
                ],
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orangeAccent.withOpacity(0.4)),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.8)),
                    width: 64,
                    height: 64,
                  ),
                  const Text('Pediatric')
                ],
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 4,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.greenAccent.withOpacity(0.4)),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.8)),
                    width: 64,
                    height: 64,
                  ),
                  Text('Dermatologist')
                ],
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueAccent.withOpacity(0.4)),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.8)),
                    width: 64,
                    height: 64,
                  ),
                  const Text('Surgeon'),
                ],
              ),
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 4,
          mainAxisCellCount: 2,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellowAccent.withOpacity(0.4)),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.8)),
                    width: 64,
                    height: 64,
                  ),
                  const Text('Internist'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // App bar
          Container(
            child: Stack(
              children: [
                Image.asset(assetIndexing.homeSliverAppbar),
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
                            const Text(
                              'Hello',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            // NAME
                            Obx(
                                  () => homeController
                                  .isUserProfileLoading.value
                                  ? CircularProgressIndicator(
                                color: colorIndex.primary,
                              )
                                  : Text(
                                homeController.userProfile.value
                                    .data?.name !=
                                    null
                                    ? homeController.userProfile
                                    .value.data!.name!
                                    : '-',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
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
                            onTap: () => {
                              homeController.onSubmitLogoutPatient()
                            },
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
                  // Center Navigation'
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1.0,
                          spreadRadius: 0.0,
                          offset: Offset(0.0,
                              1.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Call SOS
                        InkWell(
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin:
                                const EdgeInsets.only(bottom: 8),
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: Colors.grey),
                              ),
                              const Text(
                                'Call SOS',
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        //Call SOS
                        InkWell(
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin:
                                const EdgeInsets.only(bottom: 8),
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: Colors.grey),
                              ),
                              const Text(
                                'Near Hospital',
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        //Call SOS
                        InkWell(
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin:
                                const EdgeInsets.only(bottom: 8),
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: Colors.grey),
                              ),
                              const Text(
                                'Search',
                                style: TextStyle(fontSize: 14),
                              )
                            ],
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
                child: Obx(
                      () => homeController.isListDoctorsLoading.value ||
                      homeController.isUserProfileLoading.value
                      ? CircularProgressIndicator(
                    color: colorIndex.primary,
                  )
                      : widgetStaggered(),
                )),
          )
        ],
      ),
    );
  }
}