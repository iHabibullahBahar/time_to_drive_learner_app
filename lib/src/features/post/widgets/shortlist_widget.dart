import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/features/post/models/post_details_model.dart';
import 'package:ttd_learner/src/features/post/models/post_model.dart';
import 'package:ttd_learner/src/features/post/views/instructor_interaction_screen.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class ShortlistWidget extends StatelessWidget {
  ShortlistedInstructors shortlistedInstructor;
  Posts post;
  ShortlistWidget(
      {Key? key, required this.shortlistedInstructor, required this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Get.to(
            () => InstructorInteractionScreen(
              post: post,
              instructor: shortlistedInstructor,
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: zSuccessSwatch,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: zSuccessSwatch,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FancyShimmerImage(
                      imageUrl: shortlistedInstructor.image!,
                      boxFit: BoxFit.cover,
                      width: 20,
                      errorWidget: Text(
                        shortlistedInstructor.name![0],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: zTextColorLight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width - 4 * Dimensions.zDefaultPadding - 80,
                      child: Text(
                        shortlistedInstructor.name!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Gap(4),
                    Row(
                      children: [
                        Text(
                          shortlistedInstructor.totalReviews! > 0
                              ? shortlistedInstructor.totalReviews! > 1
                                  ? '${shortlistedInstructor.totalReviews} reviews'
                                  : '${shortlistedInstructor.totalReviews} review'
                              : AppLocalizations.of(context)!.noReviewsTitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: zBlackColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: zSuccessSwatch,
                  size: 14,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
