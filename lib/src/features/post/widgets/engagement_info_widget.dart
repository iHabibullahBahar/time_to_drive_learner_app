import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';
import 'package:ttd_learner/src/utils/dynamic_components.dart';

class EngagementInfoWidget extends StatelessWidget {
  int value;
  String title;
  String description;
  EngagementInfoWidget(
      {super.key,
      required this.value,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: (Get.width / 2 - 2 * Dimensions.zDefaultPadding - 5),
      decoration: BoxDecoration(
        border: DynamicComponents.zDefaultBorder,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(value.toString(),
                style: TextStyle(
                  color: title == 'Shortlisted' ? zPrimaryColor : zBlackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
            Gap(2),
            Text(
              title,
              style: TextStyle(
                color: title == 'Shortlisted' ? zPrimaryColor : zBlackColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(8),
            Container(
              width: Get.width / 2 - 2 * Dimensions.zDefaultPadding - 20,
              child: Text(
                description,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: zBlackColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
