import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class ProfileRectangleButton extends StatelessWidget {
  final bool isBackgroundColor;
  final String title;
  final String icon;
  final VoidCallback onPressed;

  const ProfileRectangleButton({
    super.key,
    this.isBackgroundColor = false,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 125,
        width: (Get.width - (Dimensions.zDefaultPadding * 2 + 10)) / 2,
        decoration: BoxDecoration(
          color:
              isBackgroundColor ? const Color(0xffFAD0B2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isBackgroundColor
              ? null
              : Border.all(
                  color: zPrimaryColor.withOpacity(0.5),
                ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                icon,
                height: 40,
                width: 40,
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: zTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: zPrimaryColor,
                    size: 20,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
