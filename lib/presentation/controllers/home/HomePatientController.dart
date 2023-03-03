import 'package:doctorcare/app/util/AsyncStorage.dart';
import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/data/models/home/ListDoctorResponse.dart';
import 'package:doctorcare/data/models/home/UserProfileResponse.dart';
import 'package:doctorcare/data/providers/network/apis/home_api.dart';
import 'package:doctorcare/presentation/pages/payment/WaitingPayment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class HomePatientController extends GetxController {
  AsyncStorage asyncStorage = AsyncStorage();

  var logger = Logger();

  var selectedTabIndex = 0.obs;

  var isListDoctorsLoading = false.obs;
  var isUserProfileLoading = false.obs;
  var listDoctors = ListDoctorResponse().obs;
  var userProfile = PatientUserProfileResponse().obs;

  Future<void> onSubmitLogoutPatient() async {
    await asyncStorage.cleanLoginState();
    await Get.deleteAll(force: true);
    Phoenix.rebirth(Get.context!);
    Get.reset();
  }

  Future getListDoctors() async {
    if (!isListDoctorsLoading.value) {
      try {
        isListDoctorsLoading.value = true;
        update();

        ListDoctorResponse response = await HomeApi().listDoctor();

        if (response.status == 'success') {
          isListDoctorsLoading.value = false;
          listDoctors.value = response;
          update();
        } else {
          FToast().warningToast(response.message);
        }
      } on Exception catch (e) {
        logger.e(e.toString());
        FToast().errorToast(e.toString());
      } finally {
        isListDoctorsLoading.value = false;
        update();
      }
    }
  }

  Widget getBiodata() {
    if (!isUserProfileLoading.value) {
      return SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 24),
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  color: Colors.grey),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  userProfile.value.data?.image != null
                      ? userProfile.value.data!.image!
                      : 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                userProfile.value.data?.name != null
                    ? userProfile.value.data!.name!
                    : '',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: genderAgeStatus(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(154),
                color: Color(0xffFFEEEE),
              ),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  getHeight(),
                  getWeight(),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 16),
                    child: const Icon(
                      Icons.bloodtype,
                      color: Colors.pink,
                    ),
                  ),
                  Expanded(
                    child: Text(userProfile.value.data!.bloodType! + ' Type'),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 16),
                    child: const Icon(
                      Icons.pin_drop_rounded,
                      color: Colors.pink,
                    ),
                  ),
                  Expanded(
                    child: Text(userProfile.value.data!.address!),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 16),
                    child: const Icon(
                      Icons.email_rounded,
                      color: Colors.pink,
                    ),
                  ),
                  Expanded(
                    child: Text(userProfile.value.data!.email!),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              width: Get.width,
              child: const Text(
                'Settings',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                FToast().errorToast('This Feature is still in Development');
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                width: Get.width,
                child: Text('Edit Data Profile'),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                logoutConfirmation();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                width: Get.width,
                child: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.pink),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }
  }

  Text getBloodType() {
    return Text('Blood: ${userProfile.value.data!.bloodType!}',
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ));
  }

  Text getHeight() {
    return Text('Height: ${userProfile.value.data!.height!.toString()} cm',
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ));
  }

  Text getWeight() {
    return Text('Weight: ${userProfile.value.data!.height!.toString()} cm',
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ));
  }

  Text genderAgeStatus() {
    return Text(
      getGender() + getAge() + getMaritalStatus(),
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );
  }

  String getGender() {
    return userProfile.value.data?.gender == 'L' ? 'Male, ' : 'Female, ';
  }

  String getAge() {
    var tempDate = userProfile.value.data?.birthDate?.split(" ");

    if (tempDate != null) {
      var year = tempDate[3];

      var now = DateTime.now();
      var formatter = DateFormat('yyyy');
      String formattedDate = formatter.format(now);

      return '${int.parse(formattedDate.toString()) - int.parse(year)} th, ';
    }
    return 'Age Undefined, ';
  }

  String getMaritalStatus() {
    return userProfile.value.data?.isMarriage == 0
        ? 'Not Married '
        : 'Married ';
  }

  Future getUserProfile() async {
    if (!isUserProfileLoading.value) {
      try {
        isUserProfileLoading.value = true;
        update();

        PatientUserProfileResponse response =
            await HomeApi().patientUserProfile();

        logger.e(response.toString());

        if (response.status == 'success') {
          isUserProfileLoading.value = false;
          userProfile.value = response;
          update();
        } else {
          FToast().warningToast(response.message);
        }
      } on Exception catch (e) {
        if (e.toString() == 'Access denied') {
          onSubmitLogoutPatient();
        }
        logger.e(e.toString());
        FToast().errorToast(e.toString());
      } finally {
        isUserProfileLoading.value = false;
        update();
      }
    }
  }

  void logoutConfirmation() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure to logout?"),
          actions: [
            TextButton(
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                onSubmitLogoutPatient();
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  void navigateToSuccessPayment() {
    Get.to(() => WaitingPayment());
  }

  void onTabNavSelected(val) async {
    selectedTabIndex.value = val;
    update();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getListDoctors();
    getUserProfile();
  }
}
