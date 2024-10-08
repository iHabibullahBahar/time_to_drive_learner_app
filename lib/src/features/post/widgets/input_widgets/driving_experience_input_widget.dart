import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/common/widgets/multicolor_text_section_widget.dart';
import 'package:ttd_learner/src/features/post/controllers/post_controller.dart';

class DrivingExperienceInputWidget extends StatefulWidget {
  const DrivingExperienceInputWidget({super.key});

  @override
  State<DrivingExperienceInputWidget> createState() =>
      _DrivingExperienceInputWidgetState();
}

class _DrivingExperienceInputWidgetState
    extends State<DrivingExperienceInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MultiColorTextSectionWidget(
          title1: "Select your ",
          title2: "driving experience",
          isTitle2Color: true,
          description: "This helps instructors tailor lessons to your level.",
        ),
        Gap(PostController.instance.spaceBetweenInput),
        GetBuilder<PostController>(
          builder: (_) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (BuildContext context) {
                      return DraggableScrollableSheet(
                        initialChildSize: 0.6,
                        minChildSize: 0.2,
                        maxChildSize: 0.9,
                        expand: false,
                        builder: (_, scrollController) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Select your driving experience',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Expanded(
                                  child: ListView(
                                    controller: scrollController,
                                    children: [
                                      for (var experience in PostController
                                              .instance
                                              .postSettingsModel
                                              .data
                                              ?.postSettings
                                              ?.experienceOptions ??
                                          [])
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              PostController.instance
                                                      .selectedExperience =
                                                  experience.value;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey.shade300,
                                                    width: 1),
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    experience.label,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ),
                                                if (PostController.instance
                                                        .selectedExperience ==
                                                    experience.value)
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Icon(Icons.check,
                                                        color: Colors.blue),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          PostController.instance.selectedExperience == ""
                              ? 'Please select your driving experience'
                              : PostController.instance.postSettingsModel.data
                                      ?.postSettings?.experienceOptions!
                                      .firstWhere((e) =>
                                          e.value ==
                                          PostController
                                              .instance.selectedExperience)
                                      .label ??
                                  '',
                          style: TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
