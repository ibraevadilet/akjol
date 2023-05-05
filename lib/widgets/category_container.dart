
import 'package:akjol/helpers/app_text_styles.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff03B0E8),
            Color(0xff008AF5),
          ],
        ),
      ),
      child: Text(
        category,
        style: AppTextStyles.s13W400(
          color: Colors.white,
        ),
      ),
    );
  }
}
