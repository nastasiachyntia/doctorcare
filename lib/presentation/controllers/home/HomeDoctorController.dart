import 'package:doctorcare/app/util/AsyncStorage.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class HomeDoctorController extends GetxController {
  AsyncStorage asyncStorage = AsyncStorage();

  Future<void> onSubmitLogoutDoctor() async {
    await asyncStorage.cleanLoginState();
    await Get.deleteAll(force: true);
    Phoenix.rebirth(Get.context!);
    Get.reset();
  }
}
