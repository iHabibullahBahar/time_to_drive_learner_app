import 'package:flutter/material.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final LinearGradient gradient;
  final double radius;
  final double height;
  final TextStyle textStyle;
  final double horizontalPadding;
  final Border border;
  final bool isGradient;

  CustomButton({
    this.gradient = zPrimaryGradientLeftToRight,
    this.radius = Dimensions.zButtonRadiusDefault,
    this.height = Dimensions.zButtonHeightDefault,
    this.horizontalPadding = 20.0,
    this.textStyle = const TextStyle(
      color: zTextColorLight,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    required this.title,
    required this.onPressed,
    this.border = const Border(),
    this.isGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: isGradient ? gradient : null,
          borderRadius: BorderRadius.circular(radius),
          border: border,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
          ),
          child: Center(
            child: Text(
              title,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
