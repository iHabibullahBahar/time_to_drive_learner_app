import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ttd_learner/src/utils/colors.dart';

class ResendOtpSection extends StatelessWidget {
  Function onPressed;
  ResendOtpSection({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.didntReceiveOtp,
          style: TextStyle(
            color: zGraySwatch[400],
          ),
        ),
        TextButton(
          onPressed: onPressed(),
          child: Text(
            AppLocalizations.of(context)!.buttonResend,
            style: TextStyle(
              color: zPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
