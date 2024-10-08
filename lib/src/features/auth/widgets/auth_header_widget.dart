import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class AuthHeaderWidget extends StatelessWidget {
  String title;
  String description;

  AuthHeaderWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
            color: zTextColor,
          ),
        ),
        Gap(10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Dimensions.fontSizeDefault,
            color: zTextColor,
          ),
        ),
      ],
    );
  }
}
