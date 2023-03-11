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

class DoctorDetail extends StatelessWidget {
  HomePatientController patientController = Get.find();
  ColorIndex colorIndex = ColorIndex();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70.withAlpha(1000),
        appBar: AppBar(
          title: Text('Doctor Detail'),
        ),
        body: SingleChildScrollView(
          child: Obx(() => patientController.isDetailDoctorLoading.value ||
                  patientController.detailDoctor.value == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            patientController.detailDoctor.value!.data!.image!,
                            width: Get.width,
                            fit: BoxFit.fitWidth,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 18,
                              top: 24,
                              bottom: 10,
                            ),
                            child: Text(
                              patientController.detailDoctor.value!.data!.name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 18,
                              bottom: 24,
                            ),
                            child: Text(
                              patientController
                                  .detailDoctor.value!.data!.specialists!.name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 18,
                              bottom: 24,
                            ),
                            child: Text(
                              patientController.detailDoctor.value!.data!
                                  .specialists!.description!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(
                                left: 18,
                                top: 16,
                                bottom: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.pink,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Experience',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            patientController.detailDoctor
                                                    .value!.data!.experience!
                                                    .toString() +
                                                ' years',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(
                                left: 18,
                                top: 16,
                                bottom: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: Colors.pink,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Study At',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            patientController.detailDoctor
                                                .value!.data!.studyAt!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 18),
                      child: Material(
                        elevation: 100,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 18, top: 18, bottom: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: const Text(
                                      'Consultation Price',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      Common.convertToIdr(
                                          int.parse(Common.removeAfterPoint(
                                              patientController
                                                  .detailDoctor
                                                  .value!
                                                  .data!
                                                  .specialists!
                                                  .amount
                                                  .toString())),
                                          2),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: colorIndex.primary),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () => Get.to(() => ChoosePayment()),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 18),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(9)),
                                    color: colorIndex.primary,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 38,
                                  ),
                                  child: const Text(
                                    'Chat Now',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
        ));
  }
}
