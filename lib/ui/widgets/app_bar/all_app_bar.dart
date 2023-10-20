import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olivia_flutter_module/core/resources/app_images.dart';

import '../main_border.dart';
import '../text/title_text.dart';
import 'base/base_app_bar.dart';

class AllAppBar extends StatelessWidget {
  final String title;
  final void Function()? onAllAppTap;

  const AllAppBar({
    super.key,
    required this.title,
    this.onAllAppTap,
  });

  @override
  Widget build(BuildContext context) {
    return BaseAppBar(
      prefix: InkWell(
        onTap: () => onAllAppTap?.call(),
        child: MainBorder(
          radius: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SvgPicture.asset(
              AppImages.icAllApp,
              height: 14,
              width: 14,
            ),
          ),
        ),
      ),
      content: TitleText(title),
    );
  }
}
