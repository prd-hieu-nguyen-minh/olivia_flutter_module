import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/pages/widgets/app_bar/base/base_app_bar.dart';
import 'package:olivia_flutter_module/pages/widgets/main_border_widget.dart';
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
      prefix: const MainBorderWidget(
        radius: 4,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Icon(
            Icons.add_box,
            size: 24,
          ),
        ),
      ),
      content: TitleText(title),
    );
  }
}
