import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/features/post/controllers/post_controller.dart';
import 'package:ttd_learner/src/features/post/models/post_model.dart';
import 'package:ttd_learner/src/features/post/widgets/shortlist_widget.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';
import 'package:ttd_learner/src/utils/dynamic_components.dart';

class PostResponseScreen extends StatelessWidget {
  Posts post;
  PostResponseScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: zDefaultAppBar(
          title: AppLocalizations.of(context)!.postResponseScreenTitle),
      backgroundColor: zBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.zDefaultPadding,
        ),
        child: ListView(
          children: [
            Gap(20),
            Obx(() {
              if (PostController.instance.isPostDetailsFetching.value) {
                return Container(
                  height: Get.height * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  child: PostController.instance.postDetailsModel.data!.id ==
                          post.id
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.title ?? "",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(30),
                            Text(
                              AppLocalizations.of(context)!
                                  .shortListInstructorTitle,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(10),
                            Text(
                              AppLocalizations.of(context)!
                                  .shortListInstructorDescription,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Gap(20),
                            for (var instructor in PostController.instance
                                .postDetailsModel.data!.shortlistedInstructors!)
                              ShortlistWidget(
                                shortlistedInstructor: instructor,
                                post: post,
                              ),
                          ],
                        )
                      : Container(),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
