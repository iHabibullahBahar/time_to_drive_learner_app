import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/common/widgets/multicolor_text_section_widget.dart';
import 'package:ttd_learner/src/features/post/controllers/post_controller.dart';

class HourlyBudgetInputWidget extends StatefulWidget {
  const HourlyBudgetInputWidget({super.key});

  @override
  State<HourlyBudgetInputWidget> createState() =>
      _HourlyBudgetInputWidgetState();
}

class _HourlyBudgetInputWidgetState extends State<HourlyBudgetInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MultiColorTextSectionWidget(
          title1: "Select your ",
          title2: "hourly budget",
          isTitle2Color: true,
          description: "Choose a budget range for your driving lessons.",
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
                                  'Select your hourly budget',
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
                                      for (var budget in PostController
                                              .instance
                                              .postSettingsModel
                                              .data
                                              ?.postSettings
                                              ?.budgetOptions ??
                                          [])
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              PostController
                                                      .instance.selectedBudget =
                                                  budget.value;
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
                                                    budget.label,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ),
                                                if (PostController.instance
                                                        .selectedBudget ==
                                                    budget.value)
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
                          PostController.instance.selectedBudget == ""
                              ? 'Please select your hourly budget'
                              : PostController.instance.postSettingsModel.data
                                      ?.postSettings?.budgetOptions!
                                      .firstWhere((b) =>
                                          b.value ==
                                          PostController
                                              .instance.selectedBudget)
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
