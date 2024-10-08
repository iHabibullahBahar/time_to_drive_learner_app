import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/images.dart';

class CommonAppBar extends StatelessWidget {
  final String imageUrl;
  final String title;
  CommonAppBar({
    super.key,
    this.imageUrl =
        "https://www.wilsoncenter.org/sites/default/files/styles/large/public/media/images/person/james-person-1.webp",
    this.title = "Apr 24, 2024"
        "",
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 55,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: FancyShimmerImage(
              imageUrl: imageUrl,
              height: 55,
              width: 55,
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: zTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: zPrimaryGradientTopToBottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              zNotificationIcon,
            ),
          ),
        )
      ],
    );
  }
}
