import 'package:flutter/material.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:pinput/pinput.dart';

class CustomPinInputField extends StatelessWidget {
  TextEditingController controller;
  CustomPinInputField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      controller: controller,
      defaultPinTheme: PinTheme(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: zPrimaryColor,
            width: 0.5,
          ),
        ),
      ),
    );
  }
}
