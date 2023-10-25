import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';

class NormalText14 extends StatelessWidget {
  final String text;

  const NormalText14(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: AppColors.colorText,
      ),
    );
  }
}
