import 'package:flutter/material.dart';
import 'package:ttd_learner/src/utils/colors.dart';

class CustomSearchbar extends StatefulWidget {
  final String hintText;
  bool isIconRequired = false;
  final onValueChanged;
  final TextEditingController controller;
  CustomSearchbar({
    this.hintText = '',
    this.isIconRequired = false,
    required this.onValueChanged,
    required this.controller,
  });

  @override
  State<CustomSearchbar> createState() => _CustomSearchbarState();
}

class _CustomSearchbarState extends State<CustomSearchbar> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      scrollPadding: const EdgeInsets.only(bottom: 100),
      style: const TextStyle(
          color: zTextColor, fontSize: 12, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        filled: true,
        fillColor: zWhiteColor,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: zTextColorPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.only(
          left: 2,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: zTextColorPrimary,
          size: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: zGraySwatch[50]!,
            width: 1,
          ),
        ),

        /// This is the border that appears when the field is not focused
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: zGraySwatch[100]!,
            width: 1,
          ),
        ),

        ///This is the border that appears when the field is focused or selected
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: zPrimaryColor,
            width: 1,
          ),
        ),
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      textInputAction: TextInputAction.done,
      onChanged: (value) {
        widget.onValueChanged(value);
      },
    );
  }
}
