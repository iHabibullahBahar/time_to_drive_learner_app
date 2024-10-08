import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/common/widgets/multicolor_text_section_widget.dart';
import 'package:ttd_learner/src/features/post/controllers/post_controller.dart';

class DescriptionInputWidget extends StatefulWidget {
  const DescriptionInputWidget({super.key});

  @override
  State<DescriptionInputWidget> createState() => _DescriptionInputWidgetState();
}

class _DescriptionInputWidgetState extends State<DescriptionInputWidget> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _descriptionController.text = PostController.instance.description;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MultiColorTextSectionWidget(
          title1: "Add a ",
          title2: "description",
          isTitle2Color: true,
          description: "Describe your post (optional)",
        ),
        Gap(PostController.instance.spaceBetweenInput),
        GetBuilder<PostController>(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText:
                          'Lets us know any preferences or challenges you may have.',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                    onChanged: (value) {
                      PostController.instance.description = value;
                      PostController.instance.update();
                    },
                  ),
                ),
              ],
            );
          },
        ),
        Gap(20),
        Text(
          'Character count: ${PostController.instance.description.length}/500',
          style: TextStyle(
            color: PostController.instance.description.length > 500
                ? Colors.red
                : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
