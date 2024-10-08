import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/common/services/common_converter.dart';
import 'package:ttd_learner/src/features/post/models/post_model.dart';
import 'package:ttd_learner/src/features/post/widgets/engagement_info_widget.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';
import 'package:ttd_learner/src/utils/dynamic_components.dart';

class PostWidget extends StatelessWidget {
  Posts post;
  PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: zWhiteColor,
          borderRadius: BorderRadius.circular(10),
          border: DynamicComponents.zDefaultBorder,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.zDefaultPadding,
            right: Dimensions.zDefaultPadding,
            top: 25,
            bottom: Dimensions.zDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.width - 4 * Dimensions.zDefaultPadding - 50,
                        child: Text(
                          post.title ?? "",
                          style: TextStyle(
                            color: zTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Gap(8),
                      Text(
                        "${AppLocalizations.of(context)!.posted} ${getTimeAgo(
                          DateTime.parse(post.createdAt!),
                        )}",

                        // '${AppLocalizations.of(context)!.posted} ${DateFormat('dd MMM yyyy').format(
                        //   DateTime.parse(post.createdAt!),
                        // )}',
                        style: TextStyle(
                          color: zBlackColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: zBlackColor,
                    size: 14,
                  ),
                ],
              ),
              Gap(25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EngagementInfoWidget(
                      value: post.totalInterested ?? 0,
                      title: AppLocalizations.of(context)!.interested,
                      description:
                          AppLocalizations.of(context)!.interestedDescription),
                  EngagementInfoWidget(
                      value: post.totalShortlisted ?? 0,
                      title: AppLocalizations.of(context)!.shortlisted,
                      description:
                          AppLocalizations.of(context)!.shortlistedDescription),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
