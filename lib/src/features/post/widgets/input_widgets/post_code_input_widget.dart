import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/common/widgets/multicolor_text_section_widget.dart';
import 'package:ttd_learner/src/features/post/controllers/post_controller.dart';

class PostCodeInputWidget extends StatefulWidget {
  const PostCodeInputWidget({super.key});

  @override
  State<PostCodeInputWidget> createState() => _PostCodeInputWidgetState();
}

class _PostCodeInputWidgetState extends State<PostCodeInputWidget> {
  bool hasEditedPostcode = false;
  Timer? _debounce;
  String previousPostalCode = '';

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onPostcodeChanged(String value, PostController controller) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      controller.selectedPostalCode = value;
      if (value.length >= 4) {
        value = value.trim();
        if (previousPostalCode == value) return;
        setState(() {
          PostController.instance.isPostCodeValidating.value = true;
        });
        previousPostalCode = value;
        bool isValid = await controller.isPostCodeValid(value);
        hasEditedPostcode = true;
        setState(() {
          PostController.instance.isPostCodeValidating.value = false;
        });
        if (isValid) {
          controller.selectedPostalCode = value;
        } else {
          controller.selectedArea = '';
        }
      } else {
        controller.selectedArea = '';
      }
      controller.update();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MultiColorTextSectionWidget(
          title1: "Enter your ",
          title2: "postcode",
          isTitle2Color: true,
          description: "We use this to find driving instructors near you.",
        ),
        Gap(PostController.instance.spaceBetweenInput),
        GetBuilder<PostController>(
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: hasEditedPostcode &&
                              PostController
                                  .instance.selectedPostalCode.isNotEmpty &&
                              PostController.instance.selectedArea.isEmpty
                          ? Colors.red
                          : PostController.instance.selectedArea.isNotEmpty
                              ? Colors.green
                              : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: PostController.instance.postalCodeController,
                    decoration: InputDecoration(
                      hintText: 'Enter your postcode',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      suffixIcon: hasEditedPostcode
                          ? controller.selectedArea.isNotEmpty
                              ? Icon(Icons.check_circle, color: Colors.green)
                              : controller.selectedPostalCode.isNotEmpty
                                  ? Icon(Icons.error, color: Colors.red)
                                  : null
                          : null,
                    ),
                    onChanged: (value) => _onPostcodeChanged(value, controller),
                  ),
                ),
                Obx(() {
                  if (PostController.instance.isPostCodeValidating.value ==
                      true) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Validating postcode...',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                        child: Column(children: [
                      if (PostController
                              .instance.selectedPostalCode.isNotEmpty &&
                          PostController.instance.selectedArea.isEmpty &&
                          hasEditedPostcode)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Invalid postcode',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      if (PostController.instance.selectedArea.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Valid postcode | ${controller.selectedArea}',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ]));
                  }
                }),
              ],
            );
          },
        ),
      ],
    );
  }
}
