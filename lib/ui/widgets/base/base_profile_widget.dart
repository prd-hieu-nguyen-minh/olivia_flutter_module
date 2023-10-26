import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';

import '../main_border.dart';

class BaseProfileWidget extends StatelessWidget {
  final Widget header;
  final Widget content;

  const BaseProfileWidget({
    super.key,
    required this.header,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return MainBorder(
      radius: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 45,
            child: header,
          ),
          const Divider(
            color: AppColors.colorLineBar,
            height: 1,
            thickness: 1,
          ),
          Expanded(
            child: content,
          ),
        ],
      ),
    );
  }
}
