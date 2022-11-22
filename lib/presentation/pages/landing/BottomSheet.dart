import 'package:doctorcare/app/extentions/color/color.dart';
import 'package:doctorcare/presentation/controllers/auth/RoleController.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class BottomSheetForm extends StatefulWidget {
  const BottomSheetForm({Key? key}) : super(key: key);

  @override
  BottomSheetFormState createState() => BottomSheetFormState();
}

class BottomSheetFormState extends State<BottomSheetForm>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> offset;
  ColorIndex colorIndex = ColorIndex();

  RoleController roleController = Get.find();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    offset = Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildBottom;
  }

  Stack get buildBottom {
    return Stack(children: [
      Container(color: Colors.blue),
      buildBottomSlide,
    ]);
  }

  Widget get buildBottomSlide {
    return SlideTransition(
      position: offset,
      child: baseModal(
        Container(),
      ),
    );
  }

  Widget baseModal(Widget thisChild) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 16,
        ),
        child: thisChild,
      ),
    );
  }

  Widget roleModal() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Hello User',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const Text(
          'Choose your role',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 24,
          ),
          child: InkWell(
            onTap: () => {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      'AS A DOCTOR',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: colorIndex.primary),
                    ),
                  )),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 24,
          ),
          child: InkWell(
            onTap: () => {},
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  color: colorIndex.primary),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: const Center(
                  child: Text(
                    'AS A PATIENT',
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
        Container(
          padding: const EdgeInsets.only(top: 24),
          child: const Center(
            child: Text(
              'Apps from Anastasia Chyntia',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
