import 'package:flutter/material.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class CustomShimmerButton extends StatelessWidget {
  double width;
  double height;
  double borderRadius;
  LinearGradient gradient;
  CustomShimmerButton({
    Key? key,
    this.width = double.infinity,
    this.height = Dimensions.zButtonHeightDefault,
    this.borderRadius = Dimensions.zButtonRadiusLarge,
    this.gradient = zPrimaryGradientLeftToRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        alignment: Alignment.center,
        height: height - 20,
        width: height - 20,
        child: CircularProgressIndicator(
          color: zTextColorLight,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
