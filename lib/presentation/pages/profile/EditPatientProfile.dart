import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/presentation/controllers/patient/EditPatientController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class EditPatientProfile extends StatelessWidget {
  EditPatientController editPatientController =
      Get.put(EditPatientController());
  ColorIndex colorIndex = ColorIndex();

  var logger = Logger();

  Row addGenderRadioButton(int btnIndex, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GetBuilder<EditPatientController>(
          builder: (_) => Radio(
              activeColor: colorIndex.primary,
              value: editPatientController.gender[btnIndex],
              groupValue: editPatientController.selectGender,
              onChanged: (value) =>
                  editPatientController.onClickGenderRadioButton(value)),
        ),
        Text(title)
      ],
    );
  }

  Row addMarriageRadioButton(int btnIndex, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GetBuilder<EditPatientController>(
          builder: (_) => Radio(
              activeColor: colorIndex.primary,
              value: editPatientController.marriage[btnIndex],
              groupValue: editPatientController.selectMarriage,
              onChanged: (value) =>
                  editPatientController.onClickMarriageRadioButton(value)),
        ),
        Text(title)
      ],
    );
  }

  void _showDialog(Widget child, BuildContext context) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  void onBirthDatePickerPressed(BuildContext context) {
    _showDialog(
      CupertinoDatePicker(
        initialDateTime: editPatientController.initialDateTime,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (DateTime newTime) {
          editPatientController.onBirthDateSelected(newTime);
        },
      ),
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: 36,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: colorIndex.primary,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            //Name
            Container(
              padding: const EdgeInsets.symmetric(vertical: 33),
              child: TextField(
                controller: editPatientController.patientNameController,
                decoration: InputDecoration(
                  labelText: 'Name',
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
            //  Gender
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: const Text(
                      'Gender',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      addGenderRadioButton(0, 'Male'),
                      addGenderRadioButton(1, 'Female'),
                    ],
                  ),
                ],
              ),
            ),
            // Birth Date
            Container(
              padding: const EdgeInsets.only(
                bottom: 33,
                top: 24,
              ),
              child: TextField(
                readOnly: true,
                controller: editPatientController.birthDateController,
                decoration: InputDecoration(
                  labelText: 'Birth of Date',
                  labelStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorIndex.primary),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      onBirthDatePickerPressed(context);
                    },
                  ),
                ),
              ),
            ),
            //  Marriage Status
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: const Text(
                      'Marriage Status',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      addMarriageRadioButton(0, 'Married'),
                      addMarriageRadioButton(1, 'Single'),
                    ],
                  ),
                ],
              ),
            ),
            //Address
            Container(
              padding: const EdgeInsets.only(top: 24),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 3,
                controller: editPatientController.addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
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

            //Blood Group
            Obx(
              () => Container(
                padding: EdgeInsets.only(
                  top: 24,
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Blood Group',
                    labelStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorIndex.primary),
                    ),
                  ),
                  hint: const Text('Blood Group'),
                  value: editPatientController.selectedBloodGroup.value,
                  onChanged: (newValue) {
                    editPatientController.onSelectedBloodGroup(newValue!);
                  },
                  items: editPatientController.bloodGroupListType
                      .map((selectedType) {
                    return DropdownMenuItem(
                      value: selectedType,
                      child: Text(
                        selectedType,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(top: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: editPatientController.weightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Weight',
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
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Text(
                          'Kg',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextField(
                      controller: editPatientController.heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Height',
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
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Text(
                        'Cm',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 16, top: 33),
              child: const Divider(
                height: 1,
                thickness: 1,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 18),
              child: const Text(
                'Account',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 33),
              child: TextField(
                enabled: false,
                readOnly: true,
                controller: editPatientController.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.black),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  fillColor: colorIndex.disabled,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorIndex.primary),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 33),
              child: TextField(
                onTap: () => {},
                enabled: false,
                readOnly: true,
                controller: editPatientController.passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: colorIndex.disabled,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: !editPatientController.obscurePassword.value
                        ? const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          ),
                    onPressed: editPatientController.onTapPasswordObscure,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorIndex.primary),
                  ),
                ),
                obscureText: !editPatientController.obscurePassword.value,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 33),
              child: TextField(
                enabled: false,
                readOnly: true,
                controller: editPatientController.confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: const TextStyle(color: Colors.black),
                  fillColor: colorIndex.disabled,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: !editPatientController.obscureConfirmPassword.value
                        ? const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          ),
                    onPressed:
                        editPatientController.onTapConfirmPasswordObscure,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorIndex.primary),
                  ),
                ),
                obscureText:
                    !editPatientController.obscureConfirmPassword.value,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                bottom: 24,
              ),
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: InkWell(
                  onTap: () {
                    editPatientController.onSubmitEditPatient();
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                        color: colorIndex.primary),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Obx(
                        () => Center(
                          child: editPatientController.isFetching.value
                              ? Transform.scale(
                                  scale: 0.7,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  'SAVE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
