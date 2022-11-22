import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/presentation/controllers/auth/RoleController.dart';
import 'package:doctorcare/presentation/controllers/patient/PatientRegistrationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SignUpPatient extends StatelessWidget {
  RoleController roleController = Get.find();

  PatientRegistrationController patientRegistrationController =
      Get.put(PatientRegistrationController());

  ColorIndex colorIndex = ColorIndex();

  Row addGenderRadioButton(int btnIndex, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GetBuilder<PatientRegistrationController>(
          builder: (_) => Radio(
              activeColor: colorIndex.primary,
              value: patientRegistrationController.gender[btnIndex],
              groupValue: patientRegistrationController.selectGender,
              onChanged: (value) => patientRegistrationController
                  .onClickGenderRadioButton(value)),
        ),
        Text(title)
      ],
    );
  }

  Row addMarriageRadioButton(int btnIndex, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GetBuilder<PatientRegistrationController>(
          builder: (_) => Radio(
              activeColor: colorIndex.primary,
              value: patientRegistrationController.marriage[btnIndex],
              groupValue: patientRegistrationController.selectMarriage,
              onChanged: (value) => patientRegistrationController
                  .onClickMarriageRadioButton(value)),
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
        initialDateTime: patientRegistrationController.initialDateTime,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (DateTime newTime) {
          patientRegistrationController.onBirthDateSelected(newTime);
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
            color: Colors.grey.shade500,
            size: 24,
          ),
          onPressed:
              patientRegistrationController.onButtonBackRegistrationPressed,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          'Registration',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: LinearPercentIndicator(
                  barRadius: const Radius.circular(10),
                  progressColor: colorIndex.primary,
                  backgroundColor: colorIndex.primary.withOpacity(0.3),
                  percent: patientRegistrationController
                      .registrationPercentage.value
                      .toDouble(),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 2, bottom: 2, left: 24),
                  child: Text(
                    'Hello New Patient',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: colorIndex.primary),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 2, bottom: 2, left: 24),
                  child: const Text(
                    'Please fill the right data so we can help you ',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 14, top: 4),
                  child: const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                )
              ],
            ),
            //REGISTRATION STEPS
            Obx(
              () =>
                  patientRegistrationController.currentRegistrationStep.value ==
                          1
                      ? registrationStepOne(context)
                      : registrationStepTwo(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget registrationStepOne(BuildContext context) {
    return Column(
      children: [
        //Name
        Container(
          padding: const EdgeInsets.only(bottom: 33),
          child: TextField(
            controller: patientRegistrationController.patientNameController,
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
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
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
            controller: patientRegistrationController.birthDateController,
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
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
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
            controller: patientRegistrationController.addressController,
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
        Container(
          padding: const EdgeInsets.only(
            bottom: 24,
            top: 32,
          ),
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: InkWell(
              onTap: () {
                patientRegistrationController
                    .onButtonNextRegistrationPressed(context);
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
                  child: const Center(
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget registrationStepTwo(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Blood Group
        Obx(
          () => DropdownButtonFormField<String>(
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
            value: patientRegistrationController.selectedBloodGroup.value,
            onChanged: (newValue) {
              patientRegistrationController.onSelectedBloodGroup(newValue!);
            },
            items: patientRegistrationController.bloodGroupListType
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
        Container(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    controller: patientRegistrationController.weightController,
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
                  controller: patientRegistrationController.heightController,
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
          padding: const EdgeInsets.only(bottom: 8),
          child: const Text(
            'Account',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 33),
          child: TextField(
            controller: patientRegistrationController.emailController,
            decoration: InputDecoration(
              labelText: 'Email',
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
          padding: const EdgeInsets.only(bottom: 33),
          child: TextField(
            controller: patientRegistrationController.passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: const TextStyle(color: Colors.grey),
              suffixIcon: IconButton(
                icon: !patientRegistrationController.obscurePassword.value
                    ? const Icon(
                        Icons.visibility_off,
                        color: Colors.grey,
                      )
                    : const Icon(
                        Icons.visibility,
                        color: Colors.grey,
                      ),
                onPressed: patientRegistrationController.onTapPasswordObscure,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorIndex.primary),
              ),
            ),
            obscureText: !patientRegistrationController.obscurePassword.value,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 33),
          child: TextField(
            controller: patientRegistrationController.confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              labelStyle: const TextStyle(color: Colors.grey),
              suffixIcon: IconButton(
                icon:
                    !patientRegistrationController.obscureConfirmPassword.value
                        ? const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          ),
                onPressed:
                    patientRegistrationController.onTapConfirmPasswordObscure,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorIndex.primary),
              ),
            ),
            obscureText:
                !patientRegistrationController.obscureConfirmPassword.value,
          ),
        ),
        Container(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(right: 19),
                child: Checkbox(
                  activeColor: colorIndex.primary,
                  value: patientRegistrationController
                      .isAgreeTermAndCondition.value,
                  onChanged: (bool? value) {
                    patientRegistrationController
                        .onTermAndConditionPressed(value!);
                  },
                ),
              ),
              const Flexible(
                child: Text(
                  'I agree the Term and Conditions and Privacy Policy',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            bottom: 24,
            top: 32,
          ),
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: InkWell(
              onTap: () {
                patientRegistrationController
                    .onButtonNextRegistrationPressed(context);
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
                      child: patientRegistrationController.isFetching.value
                          ? Transform.scale(
                              scale: 0.7,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Submit Register',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
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
    );
  }
}
