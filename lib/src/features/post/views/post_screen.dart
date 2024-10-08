import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/features/post/controllers/post_controller.dart';
import 'package:ttd_learner/src/features/post/widgets/post_widget.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: zBackgroundColor,
          elevation: 0,
        ),
      ),
      backgroundColor: zBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.zDefaultPadding,
        ),
        child: ListView(
          children: [
            Gap(20),
            Text(
              AppLocalizations.of(context)!.postScreenTitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(() {
              if (PostController.instance.isPostFetching.value) {
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
              } else if (PostController
                  .instance.postModel.data!.posts!.isEmpty) {
                return Container(
                  height: Get.height * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("No posts found"),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Column(children: [
                  Gap(10),
                  for (var post
                      in PostController.instance.postModel.data!.posts!)
                    PostWidget(post: post),
                ]);
              }
            })
          ],
        ),
      ),
    );
  }
}
