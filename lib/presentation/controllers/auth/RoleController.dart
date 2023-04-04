import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/util/AsyncStorage.dart';
import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/data/models/auth/LoginRequest.dart';
import 'package:doctorcare/data/models/auth/LoginResponse.dart';
import 'package:doctorcare/data/providers/network/apis/auth_api.dart';
import 'package:doctorcare/presentation/pages/home/HomeDoctor.dart';
import 'package:doctorcare/presentation/pages/home/HomePatient.dart';
import 'package:doctorcare/presentation/pages/signup/SignUpPatient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class RoleController extends GetxController {
  var modalBottomSteps = 1.obs;
  var isLoading = false.obs;
  var obscurePassword = true.obs;

  TextEditingController patientEmail = TextEditingController();
  TextEditingController patientPassword = TextEditingController();

  TextEditingController doctorNumber = TextEditingController();
  TextEditingController doctorPassword = TextEditingController();

  var logger = Logger();
  ColorIndex colorIndex = ColorIndex();
  AsyncStorage asyncStorage = AsyncStorage();

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    isLoading.value = false;
    update();
    roleModal();
  }

  void onAsPatientPressed() {
    everyButtonModalClicked();
    patientModal();
  }

  void onLoginAsPatientPressed() {
    everyButtonModalClicked();
    loginPatientModal();
  }

  void onLoginAsDoctorPressed() {
    everyButtonModalClicked();
    loginDoctorModal();
  }

  void onSignUpPatientPressed() {
    everyButtonModalClicked();

    isLoading.value = false;
    update();

    Get.to(() => SignUpPatient());
  }

  void onBackFromRegistrationPressed() {
    everyButtonModalClicked();
    roleModal();
  }

  void everyButtonModalClicked() {
    isLoading.value = true;
    update();
    Get.back();
  }

  void onEveryModalSuccessOpen() {
    isLoading.value = false;
    update();
  }

  void onBackButtonClicked() {
    switch (modalBottomSteps.value) {
      case 2:
        Get.back();
        roleModal();
        break;
      default:
        Get.back();
        break;
    }
  }

  void onTapPasswordObscure() {
    obscurePassword.value = !obscurePassword.value;
    update();
  }

  void loginDoctorModal() {
    onEveryModalSuccessOpen();
    modalBottomSteps.value = 2;
    Get.bottomSheet(
      isScrollControlled: true,
      baseModal(
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: () {
                      onBackButtonClicked();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      alignment: Alignment.topCenter,
                      child: Icon(
                        Icons.close_rounded,
                        color: colorIndex.primary,
                        size: 36,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 33),
                child: TextField(
                  controller: doctorNumber,
                  decoration: InputDecoration(
                    hintText: 'Doctor Number',
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorIndex.primary),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Obx(
                  () => TextField(
                    controller: doctorPassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: obscurePassword.value
                            ? const Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: Colors.grey,
                              ),
                        onPressed: onTapPasswordObscure,
                      ),
                      hintText: 'Password',
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorIndex.primary),
                      ),
                    ),
                    obscureText: obscurePassword.value,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 32),
                child: Row(
                  children: [
                    const Text(
                      'Forgot your password ',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                    InkWell(
                      child: Text(
                        'click Here',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: colorIndex.primary),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  onDoctorLogin();
                },
                child: Obx(
                      () => Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                        color: isLoading.value
                            ? colorIndex.disabled
                            : colorIndex.primary),
                    child: Container(
                      height: 44,
                      padding: EdgeInsets.symmetric(
                          vertical: isLoading.value ? 4 : 12),
                      child: Center(
                        child: isLoading.value
                            ? CircularProgressIndicator(
                          color: colorIndex.primary,
                        )
                            : const Text(
                          'LOGIN',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierColor: Colors.white.withOpacity(0),
      isDismissible: false,
      enableDrag: false,
    );
  }

  void loginPatientModal() {
    onEveryModalSuccessOpen();
    modalBottomSteps.value = 2;
    Get.bottomSheet(
      baseModal(SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: () {
                    onBackButtonClicked();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    alignment: Alignment.topCenter,
                    child: Icon(
                      Icons.close_rounded,
                      color: colorIndex.primary,
                      size: 36,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 33),
              child: TextField(
                controller: patientEmail,
                decoration: InputDecoration(
                  hintText: 'Email',
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorIndex.primary),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 25),
              child: Obx(
                () => TextField(
                  controller: patientPassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: obscurePassword.value
                          ? const Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Colors.grey,
                            ),
                      onPressed: onTapPasswordObscure,
                    ),
                    hintText: 'Password',
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorIndex.primary),
                    ),
                  ),
                  obscureText: obscurePassword.value,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 32),
              child: Row(
                children: [
                  const Text(
                    'Forgot your password ',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.grey),
                  ),
                  InkWell(
                    child: Text(
                      'click Here',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: colorIndex.primary),
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                onPatientLogin();
              },
              child: Obx(
                () => Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                      color: isLoading.value
                          ? colorIndex.disabled
                          : colorIndex.primary),
                  child: Container(
                    height: 44,
                    padding: EdgeInsets.symmetric(
                        vertical: isLoading.value ? 4 : 12),
                    child: Center(
                      child: isLoading.value
                          ? CircularProgressIndicator(
                              color: colorIndex.primary,
                            )
                          : const Text(
                              'LOGIN',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 8),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  'Don\'t have an account? ',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.grey),
                ),
                InkWell(
                  onTap: onSignUpPatientPressed,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: colorIndex.primary),
                  ),
                )
              ]),
            ),
          ],
        ),
      )),
      barrierColor: Colors.white.withOpacity(0),
      isDismissible: false,
      enableDrag: false,
    );
  }

  void patientModal() {
    onEveryModalSuccessOpen();
    modalBottomSteps.value = 2;
    Get.bottomSheet(
      baseModal(
        Container(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hello Patient',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Welcome',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      onBackButtonClicked();
                    },
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: kToolbarHeight,
                      child: Icon(
                        Icons.close_rounded,
                        color: colorIndex.primary,
                        size: 36,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                ),
                child: InkWell(
                  onTap: onSignUpPatientPressed,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: colorIndex.primary),
                          ),
                        )),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                ),
                child: InkWell(
                  onTap: onLoginAsPatientPressed,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                        color: colorIndex.primary),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: const Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 24),
                child: const Center(
                  child: Text(
                    'Apps from Anastasia Chyntia',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierColor: Colors.white.withOpacity(0),
      isDismissible: false,
      enableDrag: false,
    );
  }

  void roleModal() {
    onEveryModalSuccessOpen();
    Get.bottomSheet(
      baseModal(
        Container(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Hello User',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const Text(
                'Choose your role',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                ),
                child: InkWell(
                  onTap: onLoginAsDoctorPressed,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Text(
                            'AS A DOCTOR',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: colorIndex.primary),
                          ),
                        )),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                ),
                child: InkWell(
                  onTap: onAsPatientPressed,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                        color: colorIndex.primary),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: const Center(
                        child: Text(
                          'AS A PATIENT',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 24),
                child: const Center(
                  child: Text(
                    'Apps from Anastasia Chyntia',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierColor: Colors.white.withOpacity(0),
      isDismissible: false,
      enableDrag: false,
    );
  }

  void onPatientLogin() {
    if (patientEmail.text.trim().isEmpty) {
      FToast().errorToast('Please input Patient Email');
    } else if (patientPassword.text.trim().isEmpty) {
      FToast().errorToast('Please input Patient Password');
    } else {
      var loginPayload = LoginRequest(
          isDoctor: false,
          email: patientEmail.text,
          password: patientPassword.text);

      onSubmitLogin(loginPayload);
    }
  }

  void onDoctorLogin() {
    if (doctorNumber.text.trim().isEmpty) {
      FToast().errorToast('Please input Doctor\'s Number');
    } else if (doctorPassword.text.trim().isEmpty) {
      FToast().errorToast('Please input Doctor Password');
    } else {
      var loginPayload = LoginRequest(
          isDoctor: true,
          email: doctorNumber.text,
          password: doctorPassword.text);

      onSubmitLoginDoctor(loginPayload);
    }
  }

  void onSubmitLogin(LoginRequest payload) async {
    if (!isLoading.value) {
      try {
        isLoading.value = true;
        update();

        LoginResponse response = await AuthApi().loginPatient(payload);

        logger.i('login response : $response');

        if (response.status == 'success') {
          asyncStorage.saveToken(response.token ?? '');
          asyncStorage.setIsLoggedInAsDoctor(false);

          isLoading.value = false;
          update();

          asyncStorage.saveLoginState(response);
          Get.offAll(() => HomePatientScreen());
          FToast().successToast('Welcome ${response.data!.email!}');
        } else {
          FToast().warningToast(response.message);
        }
      } on Exception catch (e) {
        FToast().errorToast(e.toString());
      } finally {
        isLoading.value = false;
        update();
      }
    }
  }

  void onSubmitLoginDoctor(LoginRequest payload) async {
    if (!isLoading.value) {
      try {
        isLoading.value = true;
        update();

        LoginResponse response = await AuthApi().loginDoctor(payload);

        if (response.status == 'success') {
          asyncStorage.saveToken(response.token ?? '');
          asyncStorage.setIsLoggedInAsDoctor(true);

          isLoading.value = false;
          update();

          asyncStorage.saveLoginState(response);
          Get.offAll(() => HomeDoctorScreen());
          FToast().successToast('Welcome ${response.data!.email!}');
        } else {
          FToast().warningToast(response.message);
        }
      } on Exception catch (e) {
        FToast().errorToast(e.toString());
      } finally {
        isLoading.value = false;
        update();
      }
    }
  }

  Widget baseModal(Widget thisChild) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 30,
          top: 16,
          left: 16,
          right: 16,
        ),
        child: thisChild,
      ),
    );
  }
}
