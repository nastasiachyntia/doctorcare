import 'dart:ui';
import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/extentions/indexing/Illustrations.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/instance_manager.dart';

ColorIndex colorIndex = ColorIndex();

HomePatientController patientController = Get.find();

var mapWidgetDoctor = {
  'dermatologists': WidgetDoctor(
    name: 'Dermatologist \nVenereologist',
    crossAxisCellCount: 2,
    mainAxisCellCount: 4,
    assetName: AssetIndexing.skin,
    widgetColor: colorIndex.lightBlue,
    onTap: () => {},
  ),
  'pediatriс': WidgetDoctor(
    name: 'Pediatric',
    crossAxisCellCount: 2,
    mainAxisCellCount: 2,
    assetName: AssetIndexing.baby,
    widgetColor: colorIndex.lightPink,
    onTap: () => {},
  ),
  'surgeon': WidgetDoctor(
    name: 'Surgeon',
    crossAxisCellCount: 2,
    mainAxisCellCount: 2,
    assetName: AssetIndexing.surgeon,
    widgetColor: colorIndex.lightCyan,
    onTap: () => {},
  ),
  'dentist': WidgetDoctor(
    name: 'Dentist',
    crossAxisCellCount: 2,
    mainAxisCellCount: 2,
    assetName: AssetIndexing.teeth,
    widgetColor: colorIndex.lightGrey,
    onTap: () => {},
  ),
  'general': WidgetDoctor(
    name: 'General\nPractitioner',
    crossAxisCellCount: 2,
    mainAxisCellCount: 4,
    assetName: AssetIndexing.nurse,
    widgetColor: Colors.greenAccent.withOpacity(0.4),
    onTap: () => {},
  ),
  'obstetric': WidgetDoctor(
    name: 'Obstetric \nGynecologist',
    crossAxisCellCount: 2,
    mainAxisCellCount: 2,
    assetName: AssetIndexing.pregnant,
    widgetColor: colorIndex.lighterPink,
    onTap: () => {},
  ),
  'internist': WidgetDoctor(
    name: 'Internist',
    crossAxisCellCount: 2,
    mainAxisCellCount: 2,
    assetName: AssetIndexing.internist,
    widgetColor: colorIndex.lighterPink,
    onTap: () => {},
  ),
};

class WidgetDoctor {
  String? name;
  String? doctorID;
  Color? widgetColor;
  int? crossAxisCellCount;
  int? mainAxisCellCount;
  String? assetName;
  VoidCallback? onTap;

  WidgetDoctor({
    this.name,
    this.widgetColor,
    this.crossAxisCellCount,
    this.assetName,
    this.mainAxisCellCount,
    this.onTap,
  });


  @override
  String toString() {
    return 'WidgetDoctor{name: $name, doctorID: $doctorID, widgetColor: $widgetColor, crossAxisCellCount: $crossAxisCellCount, mainAxisCellCount: $mainAxisCellCount, assetName: $assetName}';
  }

  Widget getWidget() {
    return StaggeredGridTile.count(
      crossAxisCellCount: crossAxisCellCount!,
      mainAxisCellCount: mainAxisCellCount!,
      child: InkWell(
        onTap: () => patientController.navigateToListDoctorTag(name!),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21), color: widgetColor!),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Image.asset(assetName!),
                  ),
                ),
                Text(
                  name!,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
