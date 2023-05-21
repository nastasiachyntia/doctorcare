import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/presentation/controllers/home/HomeDoctorController.dart';
import 'package:doctorcare/presentation/pages/profile/EditDoctorProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorProfile extends StatelessWidget {
  HomeDoctorController doctorController = Get.find();
  ColorIndex colorIndex = ColorIndex();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Container(
                margin: EdgeInsets.all(
                  16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      doctorController.userProfile.value.data!.image!,
                      height: 64,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      doctorController.userProfile.value.data!.name!,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Experience : ' +
                          doctorController.userProfile.value.data!.experience!
                              .toString() +
                          ' Year',
                      style: TextStyle(color: Colors.black.withOpacity(0.5)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      child: Obx(() => Text(
                            doctorController
                                        .userProfile.value.data!.description !=
                                    null
                                ? doctorController
                                    .userProfile.value.data!.description!
                                : 'No Doctor Description',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.5)),
                          )),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.school_rounded,
                          color: colorIndex.primary,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          doctorController.userProfile.value.data!.studyAt!,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  ],
                )),
            Divider(
              thickness: 2,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      Get.to(() => EditDoctorProfile());
                    },
                    child: Text(
                      'Edit Data Profile',
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  InkWell(
                    onTap: () => doctorController.onSubmitLogoutDoctor(),
                    child: Text(
                      'Sign Out',
                      style: TextStyle(color: colorIndex.primary),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
