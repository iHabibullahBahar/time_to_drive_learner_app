import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/common/contollers/common_controller.dart';
import 'package:ttd_learner/src/features/auth/controllers/auth_controller.dart';
import 'package:ttd_learner/src/features/navigation_bar/controllers/navigation_controller.dart';
import 'package:ttd_learner/src/features/post/controllers/post_controller.dart';
import 'package:ttd_learner/src/features/post/views/create_post_screen.dart';
import 'package:ttd_learner/src/features/post/views/post_screen.dart';
import 'package:ttd_learner/src/features/profile/controllers/profile_controller.dart';
import 'package:ttd_learner/src/features/profile/views/profile_screen.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/images.dart';

class NavigationBarScreen extends StatefulWidget {
  NavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  List<dynamic> selectedIcons = [zAddIcon, zPostIcon, zProfileIcon];

  List<dynamic> selectedTitles = [
    'Create Post',
    'Posts',
    'Profile',
  ];

  @override
  void initState() {
    super.initState();
    Get.put(NavigationController());
    Get.put(CommonController());
    Get.put(PostController());
    Get.lazyPut(() => AuthController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        return IndexedStack(
          index: NavigationController.instance.selectedNavigationIndex.value,
          children: [
            CreatePostScreen(),
            PostScreen(),
            ProfileScreen(),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        if (NavigationController.instance.selectedNavigationIndex.value == 10) {
          return Container();
        } else {
          return SafeArea(
            child: Container(
              height: 51,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Divider(
                    height: 1,
                    thickness: 0.5,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        selectedIcons.length,
                        (index) => InkWell(
                          highlightColor: Colors.transparent,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          onTap: () async {
                            setState(() {});
                            if (index ==
                                NavigationController.instance
                                    .selectedNavigationIndex.value) return;
                            NavigationController
                                .instance.selectedNavigationIndex.value = index;
                            setState(() {});
                            if (index == 0) {
                              PostController.instance.clearCreatePostData();
                            } else if (index == 1) {
                              PostController.instance.fetchPosts();
                            } else if (index == 2) {
                            } else if (index == 3) {
                              ProfileController.instance.fetchProfile();
                            }
                          },
                          child: Container(
                            width: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  selectedIcons[index],
                                  height: 20,
                                  color: NavigationController.instance
                                              .selectedNavigationIndex.value ==
                                          index
                                      ? zPrimaryColor
                                      : zBlackColor.withOpacity(0.5),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  selectedTitles[index],
                                  style: TextStyle(
                                    color: NavigationController
                                                .instance
                                                .selectedNavigationIndex
                                                .value ==
                                            index
                                        ? zPrimaryColor
                                        : zBlackColor.withOpacity(0.5),
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
