import 'package:doctorcare/app/util/AsyncStorage.dart';
import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/data/models/Chat/ChatFirestore.dart';
import 'package:doctorcare/data/models/home/DoctorUserProfileResponse.dart';
import 'package:doctorcare/data/models/home/ListDoctorResponse.dart';
import 'package:doctorcare/data/models/home/ListSpecialistResponse.dart';
import 'package:doctorcare/data/providers/network/apis/home_api.dart';
import 'package:doctorcare/presentation/controllers/chat/ChatFirestoreController.dart';
import 'package:doctorcare/presentation/pages/chat/ChatScreen.dart';
import 'package:doctorcare/presentation/pages/history/PatientHistoryDetail.dart';
import 'package:doctorcare/presentation/pages/home/doctor/DoctorChatList.dart';
import 'package:doctorcare/presentation/pages/home/doctor/DoctorHistoryDetail.dart';
import 'package:doctorcare/presentation/pages/home/doctor/ListDoctorsDoctor.dart';
import 'package:doctorcare/presentation/pages/home/doctor/ListHistoryByDoctor.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:logger/logger.dart';

class HomeDoctorController extends GetxController {
  var logger = Logger();

  ChatFirestoreController chatFirestoreController = Get.find();

  AsyncStorage asyncStorage = AsyncStorage();
  var isUserProfileLoading = false.obs;
  var userProfile = DoctorUserProfileResponse().obs;
  var isListDoctorsLoading = false.obs;
  var listDoctors = ListDoctorResponse().obs;
  var listSpecialist = ListSpecialistResponse().obs;
  var isListSpecialistLoading = false.obs;

  var selectedFirestoreChat = ChatFirestore().obs;
  var selectedHistory = ChatFirestore().obs;

  var isLoggedIn = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getListDoctors();
    getUserProfile();
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
        FToast().errorToast(e.toString());
      } finally {
        isListDoctorsLoading.value = false;
        update();
      }
    }
  }

  void onNavigateToHistoryDoctor() {
    chatFirestoreController.filterForDoctor();
    Get.to(() => ListHistoryByDoctor());
  }

  void navigateToHistoryDetail(ChatFirestore item) {
    selectedHistory.value = item;
    update();

    Get.to(DoctorHistoryDetail());
  }

  void onChatAgainFromHistory() async {
    Get.to(ChatScreen());
  }

  void onNavigateToDoctorList() {
    Get.to(ListDoctorsDoctor());
  }

  void onNavigateToChatList() {
    Get.to(DoctorChatList());
  }

  void onNavigateToChat(ChatFirestore item) {
    selectedFirestoreChat.value = item;
    Get.to(() => ChatScreen());
  }

  Future<void> onSubmitLogoutDoctor() async {
    isLoggedIn.value = false;
    await asyncStorage.cleanLoginState();
    await Get.deleteAll(force: true);
    Phoenix.rebirth(Get.context!);
    Get.reset();
  }

  Future getUserProfile() async {
    if (!isUserProfileLoading.value) {
      try {
        isUserProfileLoading.value = true;
        update();

        DoctorUserProfileResponse response =
            await HomeApi().doctorUserProfile();

        if (response.status == 'success') {
          isLoggedIn.value = true;
          isUserProfileLoading.value = false;
          userProfile.value = response;
          logger.i(response.data!.code.toString());
          chatFirestoreController.loggedInDoctorID.value = response.data!.code!;
          update();
          chatFirestoreController.filterForDoctor();
        } else {
          isUserProfileLoading.value = false;
          FToast().warningToast(response.message);
        }
      } on Exception catch (e) {
        if (e.toString() == 'Access denied') {
          isUserProfileLoading.value = false;
          onSubmitLogoutDoctor();
        }
        FToast().errorToast(e.toString());
      } finally {
        update();
        logger.e('ID ' + chatFirestoreController.loggedInDoctorID.value);
      }
    }
  }

  Future getSpecialistList() async {
    if (!isListSpecialistLoading.value) {
      try {
        isListSpecialistLoading.value = true;
        update();

        ListSpecialistResponse response = await HomeApi().listSpecialist();

        if (response.status == 'success') {
          isListSpecialistLoading.value = false;
          listSpecialist.value = response;
          update();
        } else {
          FToast().warningToast(response.message);
        }
      } on Exception catch (e) {
        FToast().errorToast(e.toString());
      } finally {
        isListSpecialistLoading.value = false;
        update();
      }
    }
  }
}
