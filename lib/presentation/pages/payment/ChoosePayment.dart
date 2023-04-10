import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/extentions/indexing/Illustrations.dart';
import 'package:doctorcare/app/util/Common.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:doctorcare/presentation/pages/payment/WaitingPayment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoosePayment extends StatelessWidget {
  HomePatientController patientController = Get.find();
  ColorIndex colorIndex = ColorIndex();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70.withAlpha(1000),
        appBar: AppBar(
          title: Text('Payment'),
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
                      child: Container(
                          padding: EdgeInsets.only(
                            bottom: 16,
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Consultation With',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          color: Colors.grey),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Obx(
                                          () => patientController
                                                      .detailDoctor.value ==
                                                  null
                                              ? CircularProgressIndicator(
                                                  color: colorIndex.primary,
                                                )
                                              : Image.network(
                                                  patientController.detailDoctor
                                                      .value!.data!.image!,
                                                  fit: BoxFit.fill,
                                                ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 18),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            patientController.detailDoctor
                                                .value!.data!.name!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text(
                                              patientController
                                                  .detailDoctor
                                                  .value!
                                                  .data!
                                                  .specialists!
                                                  .name!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Container(
                          padding: EdgeInsets.only(
                            left: 18,
                            right: 18,
                            top: 16,
                            bottom: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Payment Detail',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 8),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Consult',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          Text(
                                            Common.convertToIdr(
                                                int.parse(
                                                    Common.removeAfterPoint(
                                                        patientController
                                                            .detailDoctor
                                                            .value!
                                                            .data!
                                                            .specialists!
                                                            .amount
                                                            .toString())),
                                                2),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Admin Fee',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          Text(
                                            Common.convertToIdr(2000, 2),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              color: colorIndex.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            Common.convertToIdr(
                                int.parse(Common.removeAfterPoint(
                                        patientController.detailDoctor.value!
                                            .data!.specialists!.amount
                                            .toString())) +
                                    2000,
                                2),
                            style: TextStyle(
                              color: colorIndex.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Container(
                          padding: EdgeInsets.only(
                            left: 18,
                            right: 18,
                            top: 16,
                            bottom: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Choose Payment',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 8),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        patientController.pickedPayment.value =
                                            'SBER';
                                        Get.off(() => WaitingPayment());
                                      },
                                      child: Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 4,
                                                spreadRadius: 0.1,
                                                offset: Offset(0.0,
                                                    0.5), // shadow direction: bottom right
                                              )
                                            ],
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Image.asset(
                                                  AssetIndexing.iconSberBank),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    left: 16,
                                                  ),
                                                  child: const Text(
                                                    'SBER Bank',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Icon(Icons.chevron_right),
                                            ],
                                          )),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        patientController.pickedPayment.value =
                                            'VTB';
                                        Get.to(() => WaitingPayment());
                                      },
                                      child: Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 4,
                                                spreadRadius: 0.1,
                                                offset: Offset(0.0,
                                                    0.5), // shadow direction: bottom right
                                              )
                                            ],
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Image.asset(
                                                  AssetIndexing.iconVtbBank),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    left: 16,
                                                  ),
                                                  child: const Text(
                                                    'VTB Bank',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Icon(Icons.chevron_right),
                                            ],
                                          )),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        patientController.pickedPayment.value =
                                            'Tinkoff';
                                        Get.to(() => WaitingPayment());
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 8),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 4,
                                              spreadRadius: 0.1,
                                              offset: Offset(0.0,
                                                  0.5), // shadow direction: bottom right
                                            )
                                          ],
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Image.asset(
                                                AssetIndexing.iconTinkOffBank),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  left: 16,
                                                ),
                                                child: const Text(
                                                  'Tinkoff Bank',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Icon(Icons.chevron_right),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                )),
        ));
  }
}
