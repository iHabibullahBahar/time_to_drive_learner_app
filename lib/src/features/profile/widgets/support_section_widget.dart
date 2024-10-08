import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttd_learner/src/features/profile/widgets/profile_custom_button.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class ProfileSectionWidget extends StatelessWidget {
  List<ProfileCustomButton> buttons;
  String title;
  ProfileSectionWidget({
    super.key,
    required this.buttons,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: zGraySwatch[100]!,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(18),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.zDefaultPadding,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: zTextColor.withOpacity(0.5),
              ),
            ),
          ),
          const Gap(5),
          for (var button in buttons) button,
        ],
      ),
    );
  }
}
