import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class NotificationWidget extends StatelessWidget {
  String title;
  String description;
  String time;
  NotificationWidget({
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: zWhiteColor,
          border: Border.all(
            color: zGraySwatch[100]!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width - 4 * Dimensions.zDefaultPadding - 100,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: zTextColor,
                        fontSize: Dimensions.fontSizeExtraLarge,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Spacer(),
                  Text(
                    time,
                    style: TextStyle(
                      color: zPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: Dimensions.fontSizeExtraSmall,
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Text(
                description,
                style: TextStyle(
                  color: zTextColor.withOpacity(0.6),
                  fontSize: Dimensions.fontSizeDefault,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
