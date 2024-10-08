import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/common/contollers/local_storage_controller.dart';
import 'package:ttd_learner/src/common/services/show_popup.dart';
import 'package:ttd_learner/src/common/widgets/custom_button.dart';
import 'package:ttd_learner/src/common/widgets/custom_circular_progress_button.dart';
import 'package:ttd_learner/src/features/auth/views/auth_method_selection_screen.dart';
import 'package:ttd_learner/src/features/auth/views/sign_in_screen.dart';
import 'package:ttd_learner/src/features/onboarding/models/onboarding_model.dart';
import 'package:ttd_learner/src/utils/app_constants.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';
import 'package:ttd_learner/src/utils/dynamic_components.dart';
import 'package:ttd_learner/src/utils/images.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  double progress = 0.33;
  late List<dynamic> onboardingList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onboardingList = [
      OnboardingModel(
        title: zOnboardingTitle1,
        description: zOnboardingDescription1,
        image: zOnboardingImage1,
        backgroundImage: zOnboardingBackground1,
      ),
      OnboardingModel(
        title: zOnboardingTitle2,
        description: zOnboardingDescription2,
        image: zOnboardingImage2,
        backgroundImage: zOnboardingBackground2,
      ),
      OnboardingModel(
        title: zOnboardingTitle3,
        description: zOnboardingDescription3,
        image: zOnboardingImage3,
        backgroundImage: zOnboardingBackground3,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            onboardingList[DynamicComponents.zCustomCircularButtonIndex]
                .backgroundImage,
          ),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent.withOpacity(0.75),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault),
            child: ListView(
              children: [
                progress == 1
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            title: AppLocalizations.of(context)!.buttonLogin,
                            height: Dimensions.zButtonHeightDefault,
                            onPressed: () {
                              LocalStorageController.instance
                                  .setBool(zIsNotFirstTime, true);
                              Get.offAll(() => const SignInScreen());
                            },
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                progress = 1;
                                DynamicComponents.zCustomCircularButtonIndex =
                                    2;
                              });
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: zTextColorLight,
                              size: 20,
                            ),
                            // child: Text(
                            //   AppLocalizations.of(context)!.buttonSkip,
                            //   style: const TextStyle(
                            //     fontSize: Dimensions.fontSizeDefault,
                            //     color: zTextColorLight,
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: Get.height * 0.7,
                  child: PageView.builder(
                    itemCount: onboardingList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Gap(310),
                          Text(
                            onboardingList[DynamicComponents
                                    .zCustomCircularButtonIndex]
                                .title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: zTextColorLight,
                            ),
                          ),
                          const Gap(20),
                          Text(
                            onboardingList[DynamicComponents
                                    .zCustomCircularButtonIndex]
                                .description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              color: zTextColorLight,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 110,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomCircularProgressButton(
                  progress: progress,
                ),
                InkWell(
                  onTap: () {
                    setState(
                      () {
                        if (DynamicComponents.zCustomCircularButtonIndex < 2) {
                          DynamicComponents.zCustomCircularButtonIndex++;
                          progress =
                              (DynamicComponents.zCustomCircularButtonIndex +
                                      1) *
                                  1.0 /
                                  3;
                        } else {
                          LocalStorageController.instance
                              .setBool(zIsNotFirstTime, true);
                          ShowPopup().showBottomPopUp(
                            context: context,
                            view: AuthMethodSelectionScreen(
                              isFromSignUp: false,
                            ),
                            height: Platform.isIOS ? 265 : 235,
                          );
                        }
                      },
                    );
                  },
                  child: Container(
                    height: 65,
                    width: 65,
                    decoration: const BoxDecoration(
                      gradient: zPrimaryGradientTopToBottom,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: progress == 1
                          ? Text(
                              AppLocalizations.of(context)!.buttonStart,
                              style: const TextStyle(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                    ),
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
