import 'package:flutter/material.dart';

import '../../../../core/resources/app_colors.dart';
import '../../../widgets/text/normal_text_14.dart';
import '../../../widgets/text/title_text.dart';

class EmployeeProfileHeader extends StatelessWidget {
  final int position;
  final int count;
  final bool isFirst;
  final bool isLast;
  final void Function()? onClose;
  final void Function(int prePosition)? onPrevious;
  final void Function(int nextPosition)? onNext;

  const EmployeeProfileHeader({
    super.key,
    required this.position,
    required this.count,
    required this.isFirst,
    required this.isLast,
    this.onClose,
    this.onPrevious,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              InkWell(
                onTap: onClose,
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.colorDescription,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              const TitleText("Employee Profile"),
              const Spacer(),
              NormalText14("$position of $count"),
              const SizedBox(width: 8),
              _buildIcon(
                Icons.keyboard_arrow_left,
                isEnable: !isFirst,
                onTap: () => onNext?.call(position - 1),
              ),
              _buildIcon(
                Icons.keyboard_arrow_right,
                isEnable: !isLast,
                onTap: () => onNext?.call(position + 1),
              ),
            ],
          ),
        ),
        const Divider(
          color: AppColors.colorLineBar,
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }

  Widget _buildIcon(
    IconData iconData, {
    required bool isEnable,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: isEnable ? onTap : null,
      child: Icon(
        iconData,
        color: isEnable ? AppColors.colorDescription : AppColors.colorLineBar,
        size: 24,
      ),
    );
  }
}
