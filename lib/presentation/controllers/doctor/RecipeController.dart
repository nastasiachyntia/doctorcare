import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/extentions/indexing/Illustrations.dart';
import 'package:doctorcare/app/util/FToast.dart';
import 'package:doctorcare/presentation/controllers/chat/ChatController.dart';
import 'package:doctorcare/presentation/pages/chat/ChatScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class RecipeController extends GetxController {
  //RECIPE : no!!nama_obat!desc!desc_obatno!!

  ColorIndex colorIndex = ColorIndex();
  var logger = Logger();

  var diagnose = ''.obs;
  var recipeDesc = ''.obs;

  TextEditingController diagnoseTextController = TextEditingController();
  TextEditingController medicineTextController = TextEditingController();
  TextEditingController recipeTextController = TextEditingController();

  ChatController chatController = Get.find();

  void onAddRecipeButtonClicked() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.close))
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Obx(() => diagnose.value.isEmpty
                  ? InkWell(
                      onTap: () {
                        Get.back();
                        onAddDiagnoseClicked();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 16, bottom: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(Icons.receipt_long_rounded,
                                color: colorIndex.primary),
                            SizedBox(
                              width: 32,
                            ),
                            Text('Add Diagnose'),
                          ],
                        ),
                      ))
                  : Container()),
              InkWell(
                  onTap: () {
                    Get.back();
                    onAddMedicineClicked();
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(AssetIndexing.iconPill, height: 24),
                        SizedBox(
                          width: 32,
                        ),
                        Text('Add Medicine'),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void onSubmitRecipe() {
    chatController.onSendRecipe(diagnose.value, recipeDesc.value);
    Get.back();
  }

  void onSaveDiagnoseClicked() {
    if (diagnoseTextController.value.text.trim().isEmpty) {
      FToast().errorToast('Diagnose must not be empty!');
    } else {
      diagnose.value = diagnoseTextController.value.text;
      update();

      Get.back();
    }
  }

  void onEditDiagnoseClicked() {
    diagnoseTextController.text = diagnose.value;
    update();

    onAddDiagnoseClicked();
  }

  void onApproveDeleteMedicine(int index) {
    Get.back();
    var splitted = recipeDesc.value.split('no!!');

    splitted.removeAt(index);

    var result = splitted.join("no!!");

    recipeDesc.value = result;

    update();
  }

  void onSaveRecipeClicked() {
    if (medicineTextController.value.text.trim().isEmpty) {
      FToast().errorToast('Diagnose must not be empty!');
    } else if (recipeTextController.value.text.trim().isEmpty) {
      FToast().errorToast('Recipe must not be empty!');
    } else {
      recipeDesc.value =
          '${recipeDesc.value}no!!${medicineTextController.value.text}!desc!${recipeTextController.value.text}';
      update();

      Get.back();
    }
  }

  void onAddDiagnoseClicked() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Input Diagnose',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.close))
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 3,
                  controller: diagnoseTextController,
                  decoration: InputDecoration(
                    labelText: 'Diagnose Description',
                    labelStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorIndex.primary),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => {onSaveDiagnoseClicked()},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  margin: EdgeInsets.only(bottom: 16),
                  width: Get.width - 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: colorIndex.primary,
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void onAddMedicineClicked() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Input Recipe',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.close))
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 1,
                  controller: medicineTextController,
                  decoration: InputDecoration(
                    labelText: 'Medicine Name',
                    labelStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorIndex.primary),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 3,
                  controller: recipeTextController,
                  decoration: InputDecoration(
                    labelText: 'Recipe Description',
                    labelStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorIndex.primary),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => {onSaveRecipeClicked()},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  margin: EdgeInsets.only(bottom: 16),
                  width: Get.width - 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: colorIndex.primary,
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void onDeleteMedicineClicked(int index) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Delete Recipe',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Center(
                child: Image.asset(AssetIndexing.approval, height: 100),
              ),
              SizedBox(
                height: 8,
              ),
              Text('Are you sure you want to delete this medicine?'),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () => {Get.back()},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  margin: EdgeInsets.only(bottom: 16),
                  width: Get.width - 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: colorIndex.primary,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              InkWell(
                onTap: () => {onApproveDeleteMedicine(index)},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  margin: EdgeInsets.only(bottom: 16),
                  width: Get.width - 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: colorIndex.primary,
                  ),
                  child: const Text(
                    'Yes Delete',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
