import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/util/Common.dart';
import 'package:doctorcare/presentation/controllers/home/HomePatientController.dart';
import 'package:doctorcare/presentation/pages/home/patient/WidgetSpecialist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SearchDoctor extends StatelessWidget {
  HomePatientController homePatientController = Get.find();
  ColorIndex colorIndex = ColorIndex();
  var logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Obx(
          () => homePatientController.isSearching.value
              ? TextField(
                  controller: homePatientController.searchController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Search Specialist Name...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                  onChanged: (query) =>
                      homePatientController.updateSearchQuery(query),
                )
              : Text(homePatientController.searchQuery.value),
        ),
        actions: [
          Obx(
            () => homePatientController.isSearching.value
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      if (homePatientController.searchController == null ||
                          homePatientController.searchController.text.isEmpty) {
                        homePatientController.clearSearchQuery();
                        return;
                      }
                      homePatientController.clearSearchQuery();
                      homePatientController.updateSearchQuery('');
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: homePatientController.startSearch(),
                  ),
          )
        ],
      ),
      body: Container(
        child: Obx(
          () => homePatientController.shownSearchedTag.value!.length > 0 ?
          ListView.builder(
            itemCount: homePatientController.shownSearchedTag.value.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return homePatientController.shownSearchedTag.value[index]
                  .getWidget();
            },
          ) : Container(
            child: Center(
              child: Text(
                homePatientController.searchController.text + ' keywords not found. Please use other Doctor Specialist keywords.',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 18),textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
