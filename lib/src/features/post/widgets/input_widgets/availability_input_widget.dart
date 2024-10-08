import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/common/widgets/multicolor_text_section_widget.dart';
import 'package:ttd_learner/src/features/post/controllers/post_controller.dart';

class AvailabilityInputWidget extends StatefulWidget {
  const AvailabilityInputWidget({super.key});

  @override
  State<AvailabilityInputWidget> createState() =>
      _AvailabilityInputWidgetState();
}

class _AvailabilityInputWidgetState extends State<AvailabilityInputWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MultiColorTextSectionWidget(
          title1: "Select your ",
          title2: "availability",
          isTitle2Color: true,
          description: "Choose the days you're available for lessons.",
        ),
        Gap(20),
        GetBuilder<PostController>(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: PostController.instance.allDays.map((day) {
                    final isSelected = PostController
                        .instance.selectedAvailableDays
                        .contains(day);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            PostController.instance.selectedAvailableDays
                                .remove(day);
                          } else {
                            PostController.instance.selectedAvailableDays
                                .add(day);
                          }
                          PostController.instance.update();
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isSelected ? Icons.check : Icons.close,
                              size: 16,
                              color: isSelected
                                  ? Colors.green.shade800
                                  : Colors.red.shade800,
                            ),
                            SizedBox(width: 4),
                            Text(
                              day,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.green.shade800
                                    : Colors.red.shade800,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 8),
                Text(
                  'Click on the days to toggle your availability.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
