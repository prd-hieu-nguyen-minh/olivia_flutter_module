import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';

class SectionWidget extends StatelessWidget {
  final Widget content;
  final Widget? suffix;
  final bool isCurrent;

  const SectionWidget({
    Key? key,
    required this.content,
    this.suffix,
    this.isCurrent = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Opacity(
              opacity: isCurrent ? 1 : 0,
              child: Container(
                width: 5,
                decoration: const BoxDecoration(
                  color: AppColors.colorPrimary,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: content,
              ),
            ),
            suffix ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
