import 'package:akjol/helpers/app_colors.dart';
import 'package:akjol/helpers/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.controller,
    this.inputFormatters,
    this.radius = 8,
    this.suffix,
    this.maxLines = 1,
    this.minLines = 1,
    this.borderColor,
  });
  final Function(String)? onChanged;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Widget? suffix;
  final double radius;
  final int maxLines;
  final int minLines;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      minLines: minLines,
      style: AppTextStyles.s15W600(
        color: AppColors.color4CADEABlue,
      ),
      controller: controller,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            width: 1,
            color: borderColor ?? AppColors.color4CADEABlue,
          ),
        ),
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            width: 1,
            color: borderColor ?? AppColors.color4CADEABlue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            width: 1,
            color: borderColor ?? AppColors.color4CADEABlue,
          ),
        ),
      ),
    );
  }
}
