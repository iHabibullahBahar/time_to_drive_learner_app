// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:ttd_learner/src/common/contollers/local_storage_controller.dart';
// import 'package:ttd_learner/src/common/widgets/custom_button.dart';
// import 'package:ttd_learner/src/common/widgets/custom_input_field.dart';
// import 'package:ttd_learner/src/common/widgets/web_view_page.dart';
// import 'package:ttd_learner/src/features/profile/controllers/profile_controller.dart';
// import 'package:ttd_learner/src/features/subscription/controllers/subscription_controller.dart';
// import 'package:ttd_learner/src/features/subscription/models/subscription_package_model.dart';
// import 'package:ttd_learner/src/utils/api_urls.dart';
// import 'package:ttd_learner/src/utils/app_constants.dart';
// import 'package:ttd_learner/src/utils/colors.dart';
//
// class SubscriptionDetailsWidget extends StatefulWidget {
//   final SubscriptionPackageModel subscriptionPackageModel;
//
//   SubscriptionDetailsWidget({required this.subscriptionPackageModel});
//
//   @override
//   State<SubscriptionDetailsWidget> createState() =>
//       _SubscriptionDetailsWidgetState();
// }
//
// class _SubscriptionDetailsWidgetState extends State<SubscriptionDetailsWidget> {
//   RxBool isAddReferClicked = false.obs;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: ProfileController
//                       .instance.profileModel.data!.subscriptionExpiryDate ==
//                   null &&
//               isAddReferClicked.value
//           ? 360
//           : isAddReferClicked.value == false
//               ? 320
//               : 240,
//       decoration: BoxDecoration(
//         color: zWhiteColor,
//         border: Border.all(
//           color: zGraySwatch[100]!,
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(25),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.subscriptionPackageModel.data!.name!,
//               style: const TextStyle(
//                 color: zTextColor,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Gap(10),
//             Text(
//               '${widget.subscriptionPackageModel.data!.unit!} ${widget.subscriptionPackageModel.data!.cost!.toString()}/month',
//               style: const TextStyle(
//                 color: zTextColor,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             if (ProfileController
//                     .instance.profileModel.data!.subscriptionExpiryDate ==
//                 null)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Gap(20),
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         isAddReferClicked.value = !isAddReferClicked.value;
//                       });
//                     },
//                     child: Text(
//                       "Add A Referral",
//                       style: const TextStyle(
//                         color: zPrimaryColor,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   Gap(10),
//                   if (isAddReferClicked.value)
//                     SizedBox(
//                       height: 50,
//                       child: CustomInputField(
//                           radius: 10,
//                           contentPaddingVertical: 12,
//                           controller: SubscriptionController
//                               .instance.referralController),
//                     ),
//                 ],
//               ),
//             Gap(10),
//             if (ProfileController
//                     .instance.profileModel.data!.subscriptionExpiryDate ==
//                 null)
//               CustomButton(
//                 title: AppLocalizations.of(context)!.buttonPayNow,
//                 onPressed: () async {
//                   var authToken = await LocalStorageController.instance
//                       .getString(zAuthToken);
//                   Get.to(
//                     () => WebViewPage(
//                       url: zApiDomain + zPaymentEndpoint,
//                       authToken: authToken!,
//                       title: "Payment",
//                       refCode: SubscriptionController
//                           .instance.referralController.text,
//                       pageName: "subscription",
//                     ),
//                   );
//                 },
//                 height: 35,
//                 radius: 7,
//               ),
//             Gap(15),
//             Expanded(
//               child: ListView.builder(
//                 itemCount:
//                     widget.subscriptionPackageModel.data!.features!.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: zPrimaryColor,
//                             borderRadius: BorderRadius.circular(100),
//                           ),
//                           child: const Padding(
//                             padding: EdgeInsets.all(2),
//                             child: Icon(
//                               Icons.check_rounded,
//                               color: zWhiteColor,
//                               size: 16,
//                             ),
//                           ),
//                         ),
//                         Gap(10),
//                         Text(
//                           widget
//                               .subscriptionPackageModel.data!.features![index],
//                           style: const TextStyle(
//                             color: zTextColor,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
