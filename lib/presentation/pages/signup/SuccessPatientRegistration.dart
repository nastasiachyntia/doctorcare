import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/extentions/indexing/Illustrations.dart';
import 'package:doctorcare/presentation/controllers/patient/PatientRegistrationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SuccessPatientRegistration extends StatelessWidget {
  PatientRegistrationController patientRegistrationController = Get.find();
  AssetIndexing assetIndexing = AssetIndexing();
  ColorIndex colorIndex = ColorIndex();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.grey.shade500,
              size: 24,
            ),
            onPressed: patientRegistrationController.onGoToMainMenuClicked,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: SvgPicture.asset(assetIndexing.successRegistration),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 24),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: const Text(
                          'Congratulations',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const Text(
                        'You have successfully registered your account in Doctor Care\'s systemLet\'s start conversation with our specialist!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 24,
                  top: 32,
                ),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: InkWell(
                    onTap: patientRegistrationController.onRedirectToLogin,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4),
                          ),
                          color: colorIndex.primary),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: const Center(
                          child: Text(
                            'Go To Main Menu',
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
              ),
            ],
          ),
        ));
  }
}
