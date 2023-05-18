import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/extentions/indexing/Illustrations.dart';
import 'package:doctorcare/app/util/Common.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:doctorcare/presentation/pages/payment/ChoosePayment.dart';
import 'package:doctorcare/presentation/pages/payment/PaymentSuccess.dart';
import 'package:doctorcare/presentation/pages/payment/WaitingPayment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientHistoryDetail extends StatelessWidget {
  HomePatientController patientController = Get.find();
  ColorIndex colorIndex = ColorIndex();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70.withAlpha(1000),
        appBar: AppBar(
          title: Text('My Recipe'),
          actions: [
            IconButton(
                onPressed: () {
                  patientController.onChatAgainFromHistory();
                },
                icon: Icon(
                  Icons.chat,
                  color: Colors.white,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 32,
                    bottom: 16,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Doctor : ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(patientController
                              .selectedHistory.value.doctorName!),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Last Consult : ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(patientController.selectedHistory.value.date!
                              .split('.')[0]),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: 16,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.receipt_long_rounded,
                            color: colorIndex.primary,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            'Diagnose',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            patientController.selectedHistory.value.diagnose!,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: 16,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(AssetIndexing.iconPill, height: 24),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            'Medicine',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            patientController.selectedHistory.value.medicine!,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
