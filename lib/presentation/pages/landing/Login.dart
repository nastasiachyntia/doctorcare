import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/extentions/indexing/Illustrations.dart';
import 'package:doctorcare/app/extentions/wording/en.dart';
import 'package:doctorcare/presentation/controllers/auth/RoleController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class Role extends StatelessWidget {
  EnglishIndexing enIndexing = EnglishIndexing();
  ColorIndex colorIndex = ColorIndex();
  RoleController roleController = Get.put(RoleController());

  var logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: colorIndex.primary,
      body: Container(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                enIndexing.label_welcome,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: SvgPicture.asset(
                AssetIndexing.loginBackdrop,
                semanticsLabel: 'Home Backdrop Background',
              ),
            ),
            // const BottomSheetForm(),
            Obx(
              () => Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: roleController.isLoading.value == true
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
