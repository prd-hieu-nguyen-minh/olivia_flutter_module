import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';

class BaseAppBar extends StatelessWidget {
  final Widget? prefix;
  final Widget? suffix;
  final Widget content;

  const BaseAppBar({
    super.key,
    this.prefix,
    this.suffix,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                left: 10,
                top: 4,
                bottom: 4,
                child: prefix ?? const SizedBox.shrink(),
              ),
              Center(
                child: content,
              ),
              Positioned(
                right: 0,
                top: 4,
                bottom: 4,
                child: suffix ?? const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          height: 1,
          color: AppColors.colorLineBar,
        ),
      ],
    );
  }
}
