import 'package:doctorcare/app/extentions/indexing/Illustrations.dart';
import 'package:doctorcare/presentation/pages/payment/PaymentSuccess.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class WaitingPayment extends StatelessWidget {
  AssetIndexing assetIndexing = AssetIndexing();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Waiting Bank Transfer'),
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
                        children: const [
                          Text(
                            '50',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Minute',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Text(
                        ':',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 36,
                        ),
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
                        children: const [
                          Text(
                            '14',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
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
                          Image.asset(assetIndexing.iconSberBank),
                          Container(
                            padding: EdgeInsets.only(
                              left: 16,
                            ),
                            child: const Text(
                              'SBER Bank',
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
                            Container(
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
                          const Expanded(
                            child: Text(
                              'Rp.90.000',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: Colors.pink),
                            ),
                          ),
                          Container(
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
                Container(
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
                        Get.to(() => PaymentSuccess());
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'ATM',
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 24,
                          )
                        ],
                      ),
                    )),
                Container(
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
                        offset:
                            Offset(0.0, 0.5), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Mobile Banking',
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 24,
                      )
                    ],
                  ),
                ),
                Container(
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
                        offset:
                            Offset(0.0, 0.5), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Internet Banking',
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
