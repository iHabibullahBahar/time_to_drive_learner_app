// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:ttd_learner/src/common/contollers/local_storage_controller.dart';
// import 'package:ttd_learner/src/common/widgets/multicolor_text_section_widget.dart';
// import 'package:ttd_learner/src/common/widgets/web_view_page.dart';
// import 'package:ttd_learner/src/features/profile/controllers/profile_controller.dart';
// import 'package:ttd_learner/src/features/subscription/controllers/subscription_controller.dart';
// import 'package:ttd_learner/src/features/subscription/widgets/subscription_details_widget.dart';
// import 'package:ttd_learner/src/utils/api_urls.dart';
// import 'package:ttd_learner/src/utils/app_constants.dart';
// import 'package:ttd_learner/src/utils/colors.dart';
// import 'package:ttd_learner/src/utils/dimensions.dart';
//
// class SubscriptionScreen extends StatefulWidget {
//   bool isBackButtonVisible = false;
//   SubscriptionScreen({super.key, this.isBackButtonVisible = false});
//
//   @override
//   State<SubscriptionScreen> createState() => _SubscriptionScreenState();
// }
//
// class _SubscriptionScreenState extends State<SubscriptionScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Get.put(ProfileController());
//     Get.put(SubscriptionController());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: zBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: zBackgroundColor,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           widget.isBackButtonVisible ? 'Subscription' : "",
//           style: TextStyle(
//             color: zTextColor,
//             fontWeight: FontWeight.w500,
//             fontSize: 18,
//             fontStyle: FontStyle.italic,
//           ),
//         ),
//         automaticallyImplyLeading: widget.isBackButtonVisible,
//         iconTheme: const IconThemeData(
//           color: zPrimaryColor,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
//         child: ListView(
//           children: [
//             const Gap(20),
//             if (!ProfileController.instance.isProfileFetching.value &&
//                 ProfileController.instance.profileModel.data != null &&
//                 ProfileController
//                         .instance.profileModel.data!.subscriptionExpiryDate !=
//                     null)
//               MultiColorTextSectionWidget(
//                 title1: 'Your ',
//                 title2: 'Current Plan',
//                 isTitle2Color: true,
//                 description: '',
//               ),
//
//             if (ProfileController.isSubscriptionExpired)
//               MultiColorTextSectionWidget(
//                 title1: 'Just One Step',
//                 title2: ' To Go',
//                 isTitle2Color: true,
//                 description: 'Enjoy a 7-Day FREE Trial',
//               ),
//             const Gap(40),
//             Obx(() {
//               if (SubscriptionController.instance.isPackageFetching.value) {
//                 return const Center(
//                     child: CircularProgressIndicator(
//                   color: zPrimaryColor,
//                 ));
//               } else {
//                 return SubscriptionDetailsWidget(
//                   subscriptionPackageModel:
//                       SubscriptionController.instance.subscriptionPackageModel,
//                 );
//               }
//             }),
//             const Gap(20),
//             if (ProfileController.instance.profileModel.data != null &&
//                 ProfileController
//                         .instance.profileModel.data!.subscriptionExpiryDate !=
//                     null)
//               Row(
//                 children: [
//                   Text(
//                     'Your Next Billing is on: ',
//                     style: TextStyle(
//                       color: zTextColor.withOpacity(0.5),
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Text(
//                     "${DateFormat('dd/MM/yyyy').format(DateTime.parse(ProfileController.instance.profileModel.data!.subscriptionExpiryDate!.toString()))}",
//                     style: TextStyle(
//                       color: zTextColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             Gap(20),
//             if (!ProfileController.instance.isProfileFetching.value &&
//                 ProfileController.instance.profileModel.data != null &&
//                 ProfileController
//                         .instance.profileModel.data!.subscriptionExpiryDate !=
//                     null)
//               InkWell(
//                 onTap: () async {
//                   var authToken = await LocalStorageController.instance
//                       .getString(zAuthToken);
//                   Get.to(
//                     () => WebViewPage(
//                         url: zApiDomain + zPaymentEndpoint,
//                         authToken: authToken!,
//                         pageName: "normal",
//                         title: "Payment"),
//                   );
//                 },
//                 child: Container(
//                   height: 45,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: zPrimaryColor,
//                       width: 1,
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Cancel Subscription",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: zPrimaryColor,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//
//             // CustomButton(
//             //   height: 40,
//             //   radius: 10,
//             //   title: "Cancel Subscription",
//             //   onPressed: () async {
//             //     var authToken = await LocalStorageController.instance
//             //         .getString(zAuthToken);
//             //     Get.to(
//             //       () => WebViewPage(
//             //           url: zApiDomain + zPaymentEndpoint,
//             //           authToken: authToken!,
//             //           pageName: "",
//             //           title: "Payment"),
//             //     );
//             //   },
//             // )
//           ],
//         ),
//       ),
//     );
//   }
// }
