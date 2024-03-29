import 'package:doctorcare/app/extentions/indexing/Illustrations.dart';
import 'package:doctorcare/app/util/Common.dart';
import 'package:doctorcare/data/models/home/WidgetDoctor.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:doctorcare/presentation/pages/payment/PaymentSuccess.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class WaitingPayment extends StatelessWidget {
  HomePatientController patientController = Get.find();
  var logger = new Logger();

  String getBankIcon(String bankName) {
    logger.i(bankName);
    switch (bankName) {
      case 'BCA':
        return AssetIndexing.iconBCA;
      case 'MANDIRI':
        return AssetIndexing.iconMandiri;
      case 'BRI':
        return AssetIndexing.iconBRI;
      case 'BNI':
        return AssetIndexing.iconBNI;
      case 'CAPITAL':
        return AssetIndexing.iconCapital;
      default:
        return AssetIndexing.iconBCA;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Waiting Bank Transfer'),
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 36,
            ),
            onPressed: patientController.onBackFromWaitingPayment,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  width: Get.width,
                  child: const Text(
                    'Please Pay your Order',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: const Text(
                    'After you finish the payment you can access chat page with your Doctor',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 24, horizontal: 17),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.pink.shade50,
                      ),
                      child: Row(
                        children: [
                          Obx(
                            () => Text(
                              patientController.minute.value,
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            'Minute',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 24, horizontal: 17),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.pink.shade50,
                      ),
                      child: Row(
                        children: [
                          Obx(
                            () => Text(
                              patientController.second.value,
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            'Second',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 24, bottom: 7),
                  child: const Text(
                    'Payment Detail',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.3),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        spreadRadius: 0.1,
                        offset:
                            Offset(0.0, 0.5), // shadow direction: bottom right
                      )
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            getBankIcon(patientController.pickedPayment.value),
                            width: 38,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 16,
                            ),
                            child: Text(
                              '${patientController.pickedPayment.value} Bank',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 28),
                        child: const Text(
                          'Bank Transfer',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                '0678714236',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async => {
                                await Clipboard.setData(
                                    const ClipboardData(text: "0678714236"))
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 2),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(
                                      color: Colors.pink, width: 1.5),
                                ),
                                child: const Text(
                                  'Copy',
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Amount to be transferred',
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              Common.convertToIdr(
                                  int.parse(Common.removeAfterPoint(
                                          patientController.detailDoctor.value!
                                              .data!.specialists!.amount
                                              .toString())) +
                                      2000,
                                  2),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: Colors.pink),
                            ),
                          ),
                          InkWell(
                            onTap: () async => {
                              await Clipboard.setData(ClipboardData(
                                  text: Common.convertToIdr(
                                          int.parse(Common.removeAfterPoint(
                                                  patientController
                                                      .detailDoctor
                                                      .value!
                                                      .data!
                                                      .specialists!
                                                      .amount
                                                      .toString())) +
                                              2000,
                                          2)
                                      .toString()))
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 2),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                border:
                                    Border.all(color: Colors.pink, width: 1.5),
                              ),
                              child: const Text(
                                'Copy',
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 24, bottom: 8),
                  child: Text(
                    'Payment Guide',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                Obx(
                  () => Container(
                      margin: EdgeInsets.only(
                        bottom: 16,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            spreadRadius: 0.2,
                            offset: Offset(
                                0.0, 0.5), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          patientController.onATMDetailClicked();
                        },
                        child: patientController.isViewATMDetail.value
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(bottom: 16),
                                        child: Text(
                                          'ATM',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_up_rounded,
                                        size: 24,
                                      )
                                    ],
                                  ),
                                  Text(
                                    '1. Insert your ATM and enter your pin.\n'
                                    '2. Select Transaction, Transfer and select between accounts.\n'
                                    '3. Enter Doctor Care Account Number.\n'
                                    '4. Enter top ammount.\n'
                                    '5. Follow the next instruction to complete top-up',
                                  )
                                ],
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      'ATM',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 24,
                                  )
                                ],
                              ),
                      )),
                ),
                Obx(
                  () => Container(
                      margin: EdgeInsets.only(
                        bottom: 16,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            spreadRadius: 0.2,
                            offset: Offset(
                                0.0, 0.5), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          patientController.onMobileBankingClicked();
                        },
                        child: patientController.isMobileBankingDetail.value
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(bottom: 16),
                                        child: Text(
                                          'Mobile Banking',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_up_rounded,
                                        size: 24,
                                      )
                                    ],
                                  ),
                                  Text(
                                    '1. Login to m-banking\n'
                                    '2. Select transfer to virtual account\n'
                                    '3. Enter Doctor Care Account Number.\n'
                                    '4. Enter top ammount.\n'
                                    '5. Enter your pin'
                                    '6. Follow the next instruction to complete top-up',
                                  )
                                ],
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      'Mobile Banking',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 24,
                                  )
                                ],
                              ),
                      )),
                ),
                Obx(
                  () => Container(
                      margin: EdgeInsets.only(
                        bottom: 16,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 0.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            spreadRadius: 0.2,
                            offset: Offset(
                                0.0, 0.5), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          patientController.onInternetBankingClicked();
                        },
                        child: patientController.isInternetBankingDetail.value
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(bottom: 16),
                                        child: Text(
                                          'Internet Banking',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_up_rounded,
                                        size: 24,
                                      )
                                    ],
                                  ),
                                  Text(
                                    '1. Login to your internet banking\n'
                                    '2. Select transfer to virtual account\n'
                                    '3. Enter Doctor Care Account Number.\n'
                                    '4. Enter top ammount.\n'
                                    '5. Enter your pin'
                                    '6. Follow the next instruction to complete top-up',
                                  )
                                ],
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      'Internet Banking',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 24,
                                  )
                                ],
                              ),
                      )),
                ),
                InkWell(
                  onTap: () => {patientController.navigateToPaymentSuccess()},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: colorIndex.primary,
                    ),
                    child: const Text(
                      'Already Paid? Click here.',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
