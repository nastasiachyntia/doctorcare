import 'dart:ui';
import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/extentions/indexing/Illustrations.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/instance_manager.dart';

ColorIndex colorIndex = ColorIndex();

HomePatientController controller = Get.find();

var mapWidgetSpecialist = {
  'dermatologist': WidgetSpecialist(
    name: 'Dermatologist \nVenereologist',
    assetName: AssetIndexing.skin,
    onTap: () => {},
  ),
  'pediatric': WidgetSpecialist(
    name: 'Pediatric',
    assetName: AssetIndexing.baby,
    onTap: () => {},
  ),
  'surgeon': WidgetSpecialist(
    name: 'Surgeon',
    assetName: AssetIndexing.surgeon,
    onTap: () => {},
  ),
  'dentist': WidgetSpecialist(
    name: 'Dentist',
    assetName: AssetIndexing.teeth,
    onTap: () => {},
  ),
  'general': WidgetSpecialist(
    name: 'General\nPractitioner',
    assetName: AssetIndexing.nurse,
    onTap: () => {},
  ),
  'gynecologist': WidgetSpecialist(
    name: 'Obstetric \nGynecologist',
    assetName: AssetIndexing.pregnant,
    onTap: () => {},
  ),
  'internist': WidgetSpecialist(
    name: 'Internist',
    assetName: AssetIndexing.internist,
    onTap: () => {},
  ),
};

class WidgetSpecialist {
  String? name;
  String? assetName;
  VoidCallback? onTap;

  WidgetSpecialist({
    this.name,
    this.assetName,
    this.onTap,
  });

  @override
  String toString() {
    return 'WidgetSpecialist{name: $name, assetName: $assetName}';
  }

  Widget getWidget() {
    return InkWell(
      onTap: () => controller.navigateToListDoctorTag(name!),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            border: Border.all(color: Colors.grey),
            color: Colors.white
          ),
          child: Row(
            children: [
              Container(
                constraints:
                    const BoxConstraints(minHeight: 100, maxHeight: 100),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Image.asset(assetName!),
              ),
              Expanded(
                child: Text(
                  name!.replaceAll('\n', ' '),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
