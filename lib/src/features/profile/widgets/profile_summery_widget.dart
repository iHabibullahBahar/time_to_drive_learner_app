import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttd_learner/src/features/profile/controllers/profile_controller.dart';
import 'package:ttd_learner/src/utils/colors.dart';

class ProfileSummeryWidget extends StatelessWidget {
  const ProfileSummeryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: zPrimaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(100),
          ),
          height: 70,
          width: 70,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              decoration: BoxDecoration(
                color: zBackgroundColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: FancyShimmerImage(
                  imageUrl:
                      ProfileController.instance.profileModel.data!.image ?? '',
                  height: 70,
                  width: 70,
                  boxFit: BoxFit.cover,
                  errorWidget: Container(
                    decoration: BoxDecoration(
                      color: zPrimaryColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: zBackgroundColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: zPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Gap(20),
        Text(
          ProfileController.instance.profileModel.data!.name!,
          style: TextStyle(
            color: zTextColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
        ),
        const Gap(20),
      ],
    );
  }
}
