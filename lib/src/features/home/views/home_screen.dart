import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttd_learner/src/common/contollers/local_storage_controller.dart';
import 'package:ttd_learner/src/features/home/controllers/home_controller.dart';
import 'package:ttd_learner/src/utils/app_constants.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: zBackgroundColor,
          elevation: 0,
        ),
      ),
      backgroundColor: zBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.zDefaultPadding,
        ),
        child: ListView(
          children: [
            InkWell(
              onTap: () async{
                print(await LocalStorageController.instance.getString(zAuthToken));
              },
              child: Container(
                height: 50,
                width: 50,
                color: Colors.red,
              ),
            )
            // Obx(() {
            //   if (true) {
            //     return CircularProgressIndicator();
            //   } else {
            //     return Column(children: []);
            //   }
            // })
          ],
        ),
      ),
    );
  }
}
