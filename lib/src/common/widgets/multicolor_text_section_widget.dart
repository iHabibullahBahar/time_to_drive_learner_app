import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class MultiColorTextSectionWidget extends StatelessWidget {
  final String title1;
  final String title2;
  final String title3;
  final bool isTitle2Color;
  final bool isTitle3Color;
  final TextStyle descriptionStyle;

  final String description;
  MultiColorTextSectionWidget({
    required this.title1,
    required this.title2,
    this.title3 = '',
    this.isTitle2Color = false,
    this.isTitle3Color = false,
    required this.description,
    this.descriptionStyle = const TextStyle(
      color: zTextColor,
      fontSize: 14,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width -
              Dimensions.zDefaultPadding * 2,
          //color: zSecondaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title2,
                style: TextStyle(
                  color: isTitle2Color ? zPrimaryColor : zTextColor,
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title3,
                style: TextStyle(
                  color: isTitle3Color ? zPrimaryColor : zTextColor,
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        if (description.isNotEmpty) Gap(5),
        if (description.isNotEmpty)
          Text(
            description,
            textAlign: TextAlign.center,
            style: descriptionStyle,
          ),
      ],
    );
  }
}
