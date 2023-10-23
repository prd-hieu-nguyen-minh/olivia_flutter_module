import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';

class DescriptionText extends StatelessWidget {
  final String text;

  const DescriptionText(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: AppColors.colorDescription,
      ),
    );
  }
}
