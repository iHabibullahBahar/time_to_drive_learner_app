import 'package:flutter/material.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class CustomButtonWithImage extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double radius;
  final double height;
  final TextStyle textStyle;
  final double horizontalPadding;
  final String image;
  const CustomButtonWithImage({
    super.key,
    this.radius = Dimensions.zButtonRadiusLarge,
    this.height = Dimensions.zButtonHeightDefault,
    this.horizontalPadding = 0.0,
    this.textStyle = const TextStyle(
      color: zTextColor,
      fontSize: 16,
    ),
    required this.title,
    required this.onPressed,
    required this.image,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
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
              Image.asset(
                image,
                width: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
