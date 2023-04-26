import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/extentions/indexing/Illustrations.dart';
import 'package:doctorcare/app/util/MapUtill.dart';
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
      children: homeController.getListDoctorWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: colorIndex.primary,
            height: 56,
          ),
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
                          onTap: () => MapUtils.launchEmegencyCaller(),
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
                        //Nearby Hospital
                        InkWell(
                          onTap: () => MapUtils.searchNearbyHospital(),
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
                        //Search
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
