import 'package:doctorcare/app/util/AsyncStorage.dart';
import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/data/models/home/ListDoctorResponse.dart';
import 'package:doctorcare/data/models/home/UserProfileResponse.dart';
import 'package:doctorcare/data/providers/network/apis/home_api.dart';
import 'package:doctorcare/presentation/pages/payment/WaitingPayment.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
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
        logger.e(e.toString());
        FToast().errorToast(e.toString());
      } finally {
        isUserProfileLoading.value = false;
        update();
      }
    }
  }

  void navigateToSuccessPayment() {
    Get.to(()=>WaitingPayment());
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
