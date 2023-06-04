import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/presentation/controllers/auth/RoleController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  RoleController roleController = Get.find();

  ColorIndex colorIndex = ColorIndex();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () async => await roleController.onSubmitResetPassword(),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          width: Get.width - 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: colorIndex.primary,
          ),
          child: const Text(
            'SAVE',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 32),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: roleController.resetEmail,
                      decoration: InputDecoration(
                        hintText: 'Your Email',
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorIndex.primary),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() => Container(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 32),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: roleController.resetPassword,
                          obscureText:
                              roleController.obscureResetPassword.value,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: roleController.obscureResetPassword.value
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: Colors.grey,
                                    ),
                              onPressed: () =>
                                  roleController.onTapResetPasswordObscure(),
                            ),
                            hintText: 'Your New Password',
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colorIndex.primary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
