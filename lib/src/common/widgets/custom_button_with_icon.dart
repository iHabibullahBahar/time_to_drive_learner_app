import 'package:flutter/material.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final LinearGradient gradient;
  final double radius;
  final double height;
  final TextStyle textStyle;
  final double horizontalPadding;
  final IconData icon;
  final Color iconColor;
  const CustomButtonWithIcon({
    super.key,
    this.gradient = zPrimaryGradientLeftToRight,
    this.radius = Dimensions.zButtonRadiusLarge,
    this.height = Dimensions.zButtonHeightDefault,
    this.horizontalPadding = 20.0,
    this.textStyle = const TextStyle(
      color: zTextColorLight,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    required this.title,
    required this.onPressed,
    required this.icon,
    this.iconColor = zTextColorLight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: textStyle,
              ),
              const Spacer(),
              Icon(
                icon,
                color: iconColor,
                size: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
