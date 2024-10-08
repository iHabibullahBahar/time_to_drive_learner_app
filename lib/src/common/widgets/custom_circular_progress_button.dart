import 'package:flutter/material.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomCircularProgressButton extends StatelessWidget {
  Color backgroundColor;
  Color foregroundColor;
  double progress;
  bool isLast = false;
  CustomCircularProgressButton(
      {required this.progress,
      this.backgroundColor = Colors.white,
      this.isLast = false,
      this.foregroundColor = zPrimaryColor});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            child: CircularPercentIndicator(
              radius: 45.0,
              animation: false,
              animationDuration: 1000,
              lineWidth: 4.0,
              percent: progress,
              linearGradient: zPrimaryGradientTopToBottom,
            ),
          ),
        ],
      ),
    );
  }
}
