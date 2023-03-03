import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/extentions/indexing/Illustrations.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class Browse extends StatelessWidget {
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
                borderRadius: BorderRadius.circular(21),
                color: colorIndex.lightBlue),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Image.asset(AssetIndexing.skin),
                    ),
                  ),
                  Text(
                    'Dermatologist\nVenereologist',
                    textAlign: TextAlign.center,
                  )
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
                borderRadius: BorderRadius.circular(21),
                color: colorIndex.lightPink),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Image.asset(AssetIndexing.baby),
                    ),
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
                borderRadius: BorderRadius.circular(21),
                color: colorIndex.lightCyan),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Image.asset(AssetIndexing.surgeon),
                    ),
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
                borderRadius: BorderRadius.circular(21),
                color: colorIndex.lightGrey),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Image.asset(AssetIndexing.teeth),
                    ),
                  ),
                  const Text('Dentist')
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
                borderRadius: BorderRadius.circular(21),
                color: Colors.greenAccent.withOpacity(0.4)),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Image.asset(AssetIndexing.nurse),
                    ),
                  ),
                  Text(
                    'General\nPractitioner',
                    textAlign: TextAlign.center,
                  )
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
                borderRadius: BorderRadius.circular(21),
                color: colorIndex.lighterPink),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Image.asset(AssetIndexing.pregnant),
                    ),
                  ),
                  const Text(
                    'Obstetric\nGynecologist',
                    textAlign: TextAlign.center,
                  ),
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
                borderRadius: BorderRadius.circular(21),
                color: colorIndex.lighterPink),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Image.asset(AssetIndexing.internist),
                    ),
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
                            const Text(
                              'Hello',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            // NAME
                            Obx(
                              () => homeController.isUserProfileLoading.value
                                  ? CircularProgressIndicator(
                                      color: colorIndex.primary,
                                    )
                                  : Text(
                                      homeController.userProfile.value.data
                                                  ?.name !=
                                              null
                                          ? homeController
                                              .userProfile.value.data!.name!
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
                            onTap: () =>
                                {homeController.onSubmitLogoutPatient()},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Obx(
                                () => homeController.isUserProfileLoading.value
                                    ? CircularProgressIndicator(
                                        color: colorIndex.primary,
                                      )
                                    : Image.network(
                                        homeController.userProfile.value.data
                                                    ?.image !=
                                                null
                                            ? homeController
                                                .userProfile.value.data!.image!
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
                          offset: Offset(
                              0.0, 1.0), // shadow direction: bottom right
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: colorIndex.secondary),
                                child: Center(
                                  child: Image.asset(
                                    AssetIndexing.sos,
                                    height: 26,
                                    width: 26,
                                  ),
                                ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: colorIndex.secondary),
                                child: Center(
                                  child: Image.asset(
                                    AssetIndexing.hospital,
                                    height: 26,
                                    width: 26,
                                  ),
                                ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                height: 44,
                                width: 44,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: colorIndex.secondary),
                                child: Center(
                                  child: Image.asset(
                                    AssetIndexing.search,
                                    height: 26,
                                    width: 26,
                                  ),
                                ),
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
