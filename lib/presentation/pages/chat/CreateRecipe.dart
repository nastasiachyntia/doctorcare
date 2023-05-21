import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/app/extentions/indexing/Illustrations.dart';
import 'package:doctorcare/presentation/controllers/doctor/RecipeController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CreateRecipe extends StatelessWidget {
  RecipeController recipeController = Get.put(RecipeController());
  ColorIndex colorIndex = ColorIndex();

  var logger = Logger();

  Future<bool> _onWillPop() async {
    return (await Get.dialog(AlertDialog(
          title: const Text('Attention!'),
          content: Text('Are you sure want cancel this recipe?'),
          actions: [
            TextButton(
              child: Text('Cancel This Recipe'),
              onPressed: () {
                Get.back();
                Get.back();
              },
            ),
            TextButton(
              child: Text('Continue'),
              onPressed: () => Get.back(),
            ),
          ],
        ))) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Create Recipe'),
            actions: [
              Obx(() => recipeController.diagnose.value.isEmpty &&
                      recipeController.recipeDesc.value.isEmpty
                  ? Container()
                  : IconButton(
                      onPressed: () =>
                          recipeController.onAddRecipeButtonClicked(),
                      icon: Icon(Icons.add),
                    )),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Obx(() =>
              recipeController.diagnose.value.isNotEmpty &&
                      recipeController.recipeDesc.value.isNotEmpty
                  ? InkWell(
                      onTap: () => recipeController.onSubmitRecipe(),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        width: Get.width - 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: colorIndex.primary,
                        ),
                        child: const Text(
                          'SAVE & SEND TO PATIENT',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Container()),
          body: SingleChildScrollView(
            child: Obx(() => recipeController.diagnose.value.isEmpty &&
                    recipeController.recipeDesc.value.isEmpty
                ? Container(
                    height: Get.height - 100,
                    width: Get.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(AssetIndexing.receiptImage, height: 100),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'You don\'t have any recipe',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text('Please input your recipe'),
                        const SizedBox(
                          height: 24,
                        ),
                        InkWell(
                          onTap: () =>
                              {recipeController.onAddDiagnoseClicked()},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            width: Get.width - 32,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: colorIndex.primary,
                            ),
                            child: const Text(
                              'INPUT DIAGNOSE',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        InkWell(
                          onTap: () =>
                              {recipeController.onAddMedicineClicked()},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            width: Get.width - 32,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: colorIndex.primary,
                            ),
                            child: const Text(
                              'INPUT MEDICINE',
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
                  )
                : Container(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => recipeController.diagnose.value.isNotEmpty
                          ? Container(
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      top: 16,
                                      bottom: 16,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.receipt_long_rounded,
                                                  color: colorIndex.primary,
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                const Text(
                                                  'Diagnose',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                                onPressed: () => recipeController
                                                    .onEditDiagnoseClicked(),
                                                icon: Icon(
                                                    Icons.more_horiz_rounded))
                                          ],
                                        ),
                                        SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Text(recipeController
                                                .diagnose.value),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container()),
                      Obx(() => recipeController.recipeDesc.value.isNotEmpty
                          ? Container(
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      top: 16,
                                      bottom: 16,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Image.asset(AssetIndexing.iconPill,
                                                height: 24),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            const Text(
                                              'Medicine',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 16),
                                        ListView.separated(
                                            separatorBuilder: (_, index) {
                                              if (index != 0) {
                                                return Divider(
                                                  thickness: 2,
                                                );
                                              }
                                              return Container();
                                            },
                                            shrinkWrap: true,
                                            itemCount: recipeController
                                                .recipeDesc.value
                                                .split('no!!')
                                                .length,
                                            itemBuilder: (_, index) {
                                              var splitted = recipeController
                                                  .recipeDesc.value
                                                  .split('no!!');
                                              var itemRecipe = splitted[index];
                                              if (itemRecipe.isNotEmpty) {
                                                var medicineName = itemRecipe
                                                    .split('!desc!')[0];
                                                var medicineDesc = itemRecipe
                                                    .split('!desc!')[1];
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          medicineName,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Text(medicineDesc),
                                                      ],
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          recipeController
                                                              .onDeleteMedicineClicked(
                                                                  index);
                                                        },
                                                        icon: Icon(Icons
                                                            .delete_rounded))
                                                  ],
                                                );
                                              } else {
                                                return Container();
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container())
                    ],
                  ))),
          ),
        ));
  }
}
