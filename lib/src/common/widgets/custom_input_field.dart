import 'package:flutter/material.dart';
import 'package:ttd_learner/src/utils/colors.dart';
import 'package:ttd_learner/src/utils/dimensions.dart';

class CustomInputField extends StatefulWidget {
  final String hintText;
  final bool isSecure;
  final IconData icon;
  bool isIconRequired = false;
  bool isEnable = true;
  final Function(String)? onChanged;
  double contentPaddingVertical = 20;
  double contentPaddingHorizontal = Dimensions.zDefaultPadding;
  //write a function that will work on

  //return a bool in onDone
  bool Function(String)? onDone;
  double radius = Dimensions.zButtonRadiusLarge;
  double height = 60;
  double bottomPadding = 10;
  TextInputType keyboardType = TextInputType.text;

  final TextEditingController controller;
  CustomInputField({
    this.hintText = '',
    this.isSecure = false,
    this.icon = Icons.email,
    this.isIconRequired = false,
    required this.controller,
    this.onChanged,
    this.onDone,
    this.radius = Dimensions.zButtonRadiusDefault,
    this.contentPaddingVertical = 20,
    this.contentPaddingHorizontal = Dimensions.zDefaultPadding,
    this.height = Dimensions.zButtonHeightDefault,
    this.bottomPadding = 10,
    this.isEnable = true,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomPadding),
      child: SizedBox(
        height: widget.height,
        child: TextFormField(
          readOnly: widget.isEnable ? false : true,
          controller: widget.controller,
          obscureText: widget.isSecure ? !isPasswordVisible : false,
          scrollPadding: const EdgeInsets.only(bottom: 100),
          style:
              TextStyle(color: widget.isEnable ? zTextColor : zGraySwatch[400]),
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.isEnable ? zWhiteColor : zGraySwatch[50],

            enabled: widget.isEnable,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(
                right: Dimensions.paddingSizeLarge,
              ),
              child: widget.isIconRequired
                  ? InkWell(
                      onTap: widget.isSecure
                          ? () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            }
                          : () {},
                      child: Icon(
                        widget.isSecure
                            ? isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility
                            : widget.icon,
                        color: zPrimaryColor,
                      ),
                    )
                  : null,
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: widget.contentPaddingVertical,
                horizontal: widget.contentPaddingHorizontal),
            hintText: widget.hintText,

            hintStyle: TextStyle(
              color: zGraySwatch[400],
              fontSize: Dimensions.fontSizeDefault,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                color: zGraySwatch[50]!,
                width: 1,
              ),
            ),

            /// This is the border that appears when the field is not focused
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                color: zGraySwatch[100]!,
                width: 1,
              ),
            ),

            ///This is the border that appears when the field is focused or selected
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: const BorderSide(
                color: zPrimaryColor,
                width: 1,
              ),
            ),
          ),
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
            //widget.onDone!();
          },
          textInputAction: TextInputAction.done,
          keyboardType: widget.keyboardType,
          onChanged: (value) {},
        ),
      ),
    );
  }
}
