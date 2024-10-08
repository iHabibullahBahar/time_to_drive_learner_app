import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class CustomButtonWithLeftIcon extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final LinearGradient gradient;
  final double radius;
  final double height;
  final TextStyle textStyle;
  final double horizontalPadding;
  final Widget widget;
  final Color iconColor;
  final isGradient;
  const CustomButtonWithLeftIcon({
    super.key,
    this.gradient = zPrimaryGradientLeftToRight,
    this.radius = Dimensions.zButtonRadiusLarge,
    this.height = Dimensions.zButtonHeightDefault,
    this.horizontalPadding = 20.0,
    this.isGradient = true,
    this.widget = const Icon(
      Icons.favorite,
      color: zPrimaryColor,
      size: 24,
    ),
    this.textStyle = const TextStyle(
      color: zTextColorLight,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    required this.title,
    required this.onPressed,
    this.iconColor = zTextColorLight,
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
          border: Border.all(
            color: zPrimaryColor,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget,
              Gap(10),
              Text(
                title,
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
