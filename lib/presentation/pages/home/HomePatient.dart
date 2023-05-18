import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/presentation/controllers/chat/ChatFirestoreController.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:doctorcare/presentation/pages/home/patient/Browse.dart';
import 'package:doctorcare/presentation/pages/home/patient/ListDoctor.dart';
import 'package:doctorcare/presentation/pages/home/patient/ListHistory.dart';
import 'package:doctorcare/presentation/pages/home/patient/UpComing.dart';
import 'package:doctorcare/presentation/pages/profile/PatientProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class HomePatientScreen extends StatelessWidget {
  HomePatientController homeController =
      Get.put(HomePatientController(), permanent: true);
  ColorIndex colorIndex = ColorIndex();

  ChatFirestoreController chatFirestoreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.apps_rounded),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'Doctor List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note_rounded),
              label: 'My History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts_outlined),
              label: 'Account',
            ),
          ],
          currentIndex: homeController.selectedTabIndex.value,
          selectedItemColor: colorIndex.primary,
          unselectedItemColor: colorIndex.primary,
          onTap: (val) {
            homeController.onTabNavSelected(val);

            if(val == 2){
              chatFirestoreController.filterForPatient();
            }
          },
        ),
        body: Obx(() => IndexedStack(
              index: homeController.selectedTabIndex.value.toInt(),
              children: [
                Browse(),
                ListDoctors(),
                // UpComing(),
                ListHistory(),
                PatientProfile(),
              ],
            )));
  }
}
