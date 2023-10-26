import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';

class CommonTabBar extends TabBar {
  const CommonTabBar({
    super.key,
    required super.controller,
    required super.tabs,
    super.isScrollable = true,
    super.indicatorWeight = 3,
    super.indicatorColor = AppColors.colorPrimary,
    super.labelColor = AppColors.colorPrimary,
    super.unselectedLabelColor = AppColors.colorText,
    super.labelPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 10,
    ),
    super.labelStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 13,
    ),
  });
}
