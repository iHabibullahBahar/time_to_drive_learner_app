import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class ProfileCustomButton extends StatelessWidget {
  IconData icon;
  String title;
  bool isHorizontalDivider;
  Function() onPressed;
  ProfileCustomButton({
    super.key,
    required this.icon,
    required this.title,
    this.isHorizontalDivider = true,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: zPrimaryColor.withOpacity(0.9),
                    size: 20,
                  ),
                  const Gap(10),
                  Text(
                    title,
                    style: TextStyle(
                      color: zTextColor.withOpacity(0.8),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: zTextColor.withOpacity(0.5),
                    size: 18,
                  ),
                ],
              ),
            ),
            if (isHorizontalDivider)
              Container(
                height: 1,
                color: zGraySwatch[100]!.withOpacity(0.6),
              ),
          ],
        ),
      ),
    );
  }
}
