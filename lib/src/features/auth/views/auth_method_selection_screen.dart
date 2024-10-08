import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/common/widgets/custom_button_with_icon.dart';
import 'package:ttd_learner/src/common/widgets/custom_button_with_image.dart';
import 'package:ttd_learner/src/features/auth/controllers/auth_controller.dart';
import 'package:ttd_learner/src/features/auth/views/sign_in_screen.dart';
import 'package:ttd_learner/src/features/auth/views/sign_up_screen.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';
import 'package:ttd_learner/src/utils/images.dart';

class AuthMethodSelectionScreen extends StatelessWidget {
  bool isFromSignUp = false;
  AuthMethodSelectionScreen({Key? key, this.isFromSignUp = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: Platform.isIOS ? 185 : 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: zWhiteColor,
              borderRadius:
                  BorderRadius.circular(Dimensions.zButtonRadiusLarge),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraLarge),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonWithImage(
                    backgroundColor: zWhiteColor,
                    image: zEmailIcon,
                    onPressed: () {
                      if (isFromSignUp) {
                        Get.to(() => SignUpScreen());
                      } else {
                        Get.to(() => SignInScreen());
                      }
                    },
                    title:
                        '${AppLocalizations.of(context)!.buttonContinueWith} Email',
                  ),
                  Divider(
                    color: zGraySwatch[100],
                    thickness: 1,
                    height: 0.5,
                  ),
                  if (Platform.isIOS)
                    CustomButtonWithImage(
                      backgroundColor: zWhiteColor,
                      image: zAppleIcon,
                      onPressed: () {},
                      title:
                          '${AppLocalizations.of(context)!.buttonContinueWith} Apple',
                    ),
                  if (Platform.isIOS)
                    Divider(
                      color: zGraySwatch[100],
                      thickness: 1,
                      height: 0.5,
                    ),
                  CustomButtonWithImage(
                    backgroundColor: zWhiteColor,
                    image: zGoogleIcon,
                    onPressed: () async {
                      Get.put(AuthController());
                      await AuthController.instance.signInWithGoogle();
                    },
                    title:
                        '${AppLocalizations.of(context)!.buttonContinueWith} Google',
                  ),
                ],
              ),
            )),
        const Gap(20),
        CustomButtonWithIcon(
          gradient: const LinearGradient(
            colors: [
              zWhiteColor,
              zWhiteColor,
            ],
          ),
          textStyle: const TextStyle(
            color: zErrorSwatch,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          title: AppLocalizations.of(context)!.buttonCancel,
          onPressed: () {
            Get.back();
          },
          icon: Icons.close,
          iconColor: zErrorSwatch,
        ),
      ],
    );
  }
}
