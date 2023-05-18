import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/extentions/indexing/Illustrations.dart';
import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/data/models/home/WidgetDoctor.dart';
import 'package:doctorcare/presentation/pages/chat/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class PaymentSuccess extends StatelessWidget {
  ColorIndex colorIndex = ColorIndex();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Success'),
      ),
      body: Container(
        height: Get.height,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(AssetIndexing.paymentSuccess),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 24, bottom: 16),
                    width: Get.width,
                    child: const Text(
                      'Payment Success',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: Get.width,
                    child: Text(
                      'Congratulations! Your payment has been accepted. You now can proceed to chat with your Doctor and consulting about your health. Get well soon!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: patientController.onPaymentSuccessPressed,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: colorIndex.primary,
                ),
                child: const Text(
                  'Consult Now',
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
    );
  }
}
