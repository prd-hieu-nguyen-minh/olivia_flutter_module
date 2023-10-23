import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';

import '../../text/normal_text_16.dart';

class DesktopHeaderToolbar extends StatelessWidget {
  final String title;

  const DesktopHeaderToolbar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                NormalText16(title),
                const Spacer(),
                _buildNotificationIcon(),
                const SizedBox(width: 16),
                _buildSearchIcon(),
                const SizedBox(width: 32),
                _buildAssistIcon(),
              ],
            ),
          ),
        ),
        const Divider(
          thickness: 1,
          color: AppColors.colorLineBar,
        ),
      ],
    );
  }

  Widget _buildNotificationIcon() {
    return const Icon(
      Icons.notifications,
      color: AppColors.colorDescription,
      size: 24,
    );
  }

  Widget _buildSearchIcon() {
    return const Icon(
      Icons.search,
      color: AppColors.colorDescription,
      size: 24,
    );
  }

  Widget _buildAssistIcon() {
    return const Row(
      children: [
        SizedBox.square(
          dimension: 36,
          child: CircleAvatar(
            backgroundColor: AppColors.colorPrimary,
            child: Icon(
              Icons.mic,
              color: AppColors.colorWhite,
              size: 18,
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          "Assist",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.colorPrimary,
          ),
        ),
      ],
    );
  }
}
