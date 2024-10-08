import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';
import 'package:ttd_learner/src/utils/images.dart';

class ProfileEditButton extends StatelessWidget {
  final String title;
  final String icon;
  final String value;
  final String unit;
  final bool isValueRequired;
  final VoidCallback onPressed;
  bool isCustomIcon;

  ProfileEditButton({
    super.key,
    required this.title,
    required this.icon,
    this.value = "",
    this.unit = "",
    this.isValueRequired = false,
    required this.onPressed,
    this.isCustomIcon = false,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: zPrimaryColor.withOpacity(0.35),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.zDefaultPadding,
              vertical: 12,
            ),
            child: Row(
              children: [
                Image.asset(
                  icon,
                  height: 55,
                  width: 55,
                ),
                const Gap(10),
                Container(
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: zTextColor.withOpacity(0.75),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      if (isValueRequired) const Gap(2),
                      if (isValueRequired)
                        Row(
                          children: [
                            Text(
                              value,
                              style: TextStyle(
                                color: zTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              unit,
                              style: TextStyle(
                                color: zTextColor.withOpacity(0.5),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            )
                          ],
                        )
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    onPressed();

                    /// TODO: Implement edit functionality
                  },
                  child: !isCustomIcon
                      ? Image.asset(
                          zEditIcon,
                          height: 24,
                          width: 24,
                        )
                      : Icon(
                          Icons.camera_alt,
                          color: zPrimaryColor,
                          size: 24,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
