import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/common/widgets/custom_button.dart';
import 'package:ttd_learner/src/features/navigation_bar/controllers/navigation_controller.dart';
import 'package:ttd_learner/src/features/post/controllers/post_controller.dart';
import 'package:ttd_learner/src/features/post/widgets/input_widgets/availability_input_widget.dart';
import 'package:ttd_learner/src/features/post/widgets/input_widgets/description_input_widget.dart';
import 'package:ttd_learner/src/features/post/widgets/input_widgets/driving_experience_input_widget.dart';
import 'package:ttd_learner/src/features/post/widgets/input_widgets/hourly_budget_input_widget.dart';
import 'package:ttd_learner/src/features/post/widgets/input_widgets/post_code_input_widget.dart';
import 'package:ttd_learner/src/features/post/widgets/input_widgets/title_input_widget.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';
import 'package:ttd_learner/src/utils/dynamic_components.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  List<Widget> inputWidgets = [
    TitleInputWidget(),
    DescriptionInputWidget(),
    DrivingExperienceInputWidget(),
    HourlyBudgetInputWidget(),
    AvailabilityInputWidget(),
    PostCodeInputWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: zDefaultAppBar(
        title: AppLocalizations.of(context)!.createPostScreenTitle,
        isShowLeading: PostController.instance.currentIndex == 0 ? false : true,
        onTapLeading: () {
          setState(() {
            PostController.instance.currentIndex--;
          });
          if (PostController.instance.currentIndex == 0) {
            Navigator.pop(context);
          }
          print(PostController.instance.currentIndex);
        },
      ),
      backgroundColor: zBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.zDefaultPadding,
        ),
        child: ListView(
          children: [
            Gap(20),
            inputWidgets[PostController.instance.currentIndex],

            // Obx(() {
            //   if (true) {
            //     return CircularProgressIndicator();
            //   } else {
            //     return Column(children: []);
            //   }
            // })
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 65,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(
                height: 1,
                thickness: 0.5,
              ),
              Gap(5),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.zDefaultPadding,
                ),
                child: CustomButton(
                  title: PostController.instance.currentIndex ==
                          inputWidgets.length - 1
                      ? "Create Post"
                      : "Continue",
                  onPressed: () async {
                    if (PostController.instance.currentIndex <
                        inputWidgets.length - 1) {
                      if (PostController.instance.validateCurrentStep()) {
                        if (PostController.instance.currentIndex > 0) {
                          setState(() {
                            PostController.instance.currentIndex++;
                          });
                        } else {
                          PostController.instance.currentIndex++;
                          Get.to(() => CreatePostScreen());
                        }
                      }
                    } else {
                      if (PostController.instance
                          .validateCurrentStep()) if (await PostController
                              .instance
                              .createPost() ==
                          true) {
                        NavigationController
                            .instance.selectedNavigationIndex.value = 1;
                        Navigator.of(context).pop();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
