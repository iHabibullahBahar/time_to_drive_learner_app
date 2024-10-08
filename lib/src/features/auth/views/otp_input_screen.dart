import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:ttd_learner/src/common/contollers/local_storage_controller.dart';
import 'package:ttd_learner/src/common/widgets/custom_button_with_icon.dart';
import 'package:ttd_learner/src/common/widgets/custom_pin_input_field.dart';
import 'package:ttd_learner/src/features/auth/controllers/auth_controller.dart';
import 'package:ttd_learner/src/features/auth/widgets/auth_header_widget.dart';
import 'package:ttd_learner/src/utils/app_constants.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class OtpInputScreen extends StatefulWidget {
  const OtpInputScreen({super.key});

  @override
  State<OtpInputScreen> createState() => _OtpInputScreenState();
}

class _OtpInputScreenState extends State<OtpInputScreen> {
  Timer? _timer;
  int _start = 30;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void startTimer() {
    _start = 30;
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {});
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zBackgroundColor,
      appBar: AppBar(
        backgroundColor: zBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: zPrimaryColor,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.zDefaultPadding),
          child: ListView(
            children: [
              Gap(170),
              // Image.asset(
              //   zForgotPasswordImage,
              //   height: 150,
              // ),
              Gap(40),
              AuthHeaderWidget(
                title: AppLocalizations.of(context)!.otpTitle,
                description: AppLocalizations.of(context)!.otpDescription,
              ),
              const Gap(30),
              CustomPinInputField(
                controller: AuthController.instance.otpController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.didntReceiveOtp,
                    style: TextStyle(
                      color: zGraySwatch[400],
                    ),
                  ),
                  TextButton(
                    onPressed: _start == 0
                        ? () async {
                            var userId = await LocalStorageController.instance
                                .getInt(zUserId);
                            var email = await LocalStorageController.instance
                                .getString(zEmail);
                            AuthController.instance.sendOTP(
                              userId,
                              email,
                            );
                            AuthController.instance.otpController.clear();
                            setState(() {
                              startTimer();
                            });
                          }
                        : null,
                    child: Text(
                      _start == 0
                          ? AppLocalizations.of(context)!.buttonResend
                          : '${AppLocalizations.of(context)!.buttonResend} (${_start}s)',
                      style: TextStyle(
                        color: _start == 0 ? zPrimaryColor : zGraySwatch[400],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(
          bottom: Dimensions.zDefaultPadding,
          left: Dimensions.zDefaultPadding,
          right: Dimensions.zDefaultPadding,
        ),
        child: CustomButtonWithIcon(
          title: AppLocalizations.of(context)!.buttonSubmit,
          onPressed: () {
            AuthController.instance.verifyOTP(
              AuthController.instance.otpController.text,
            );
          },
          icon: Icons.arrow_forward_ios,
        ),
      ),
    );
  }
}
