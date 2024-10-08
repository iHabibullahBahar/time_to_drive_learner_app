import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/features/auth/controllers/auth_controller.dart';
import 'package:ttd_learner/src/features/auth/widgets/social_button.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';
import 'package:ttd_learner/src/utils/images.dart';

class SocialButtonSectionWidget extends StatelessWidget {
  const SocialButtonSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 1,
              width: Get.width / 2 - (Dimensions.zDefaultPadding + 40),
              color: zGraySwatch[100],
            ),
            Text(
              "  Or  ",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: zTextColor,
              ),
            ),
            Container(
              height: 1,
              width: Get.width / 2 - (Dimensions.zDefaultPadding + 40),
              color: zGraySwatch[100],
            ),
          ],
        ),
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialButton(
              icon: zGoogleIcon,
              onPressed: () async {
                await AuthController.instance.signInWithGoogle();
              },
            ),
            if (Platform.isIOS) Gap(20),
            if (Platform.isIOS)
              SocialButton(
                onPressed: () {
                  /// TODO Implement Apple Login
                },
                icon: zAppleIcon,
              )
          ],
        ),
      ],
    );
  }
}
