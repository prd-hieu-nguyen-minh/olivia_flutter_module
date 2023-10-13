import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olivia_flutter_module/core/resources/app_images.dart';
import 'package:olivia_flutter_module/pages/widgets/app_bar/base/base_app_bar.dart';
import 'package:olivia_flutter_module/pages/widgets/main_border.dart';
import 'package:olivia_flutter_module/pages/widgets/text/title_text.dart';

class AllAppBar extends StatelessWidget {
  final String title;

  const AllAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BaseAppBar(
      prefix: MainBorder(
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
      content: TitleText(title),
    );
  }
}
