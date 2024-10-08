import 'package:flutter/material.dart';
import 'package:ttd_learner/src/utils/colors.dart';

class SocialButton extends StatelessWidget {
  Function onPressed;
  String icon;
  SocialButton({Key? key, required this.onPressed, required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: zPrimaryColor,
            )),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            icon,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}
