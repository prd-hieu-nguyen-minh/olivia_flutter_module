import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';
import 'package:olivia_flutter_module/pages/widgets/app_bar/base/base_app_bar.dart';
import 'package:olivia_flutter_module/pages/widgets/base/base_phone_page.dart';
import 'package:olivia_flutter_module/pages/widgets/text/description_text.dart';
import 'package:olivia_flutter_module/pages/widgets/text/title_text.dart';

class PhoneEmployeeContentPage extends StatefulWidget {
  final MenuSection menuSection;

  const PhoneEmployeeContentPage({
    super.key,
    required this.menuSection,
  });

  @override
  State<PhoneEmployeeContentPage> createState() => _PhoneEmployeeContentPageState();
}

class _PhoneEmployeeContentPageState extends State<PhoneEmployeeContentPage> {
  @override
  Widget build(BuildContext context) {
    return BasePhonePage(
      body: Column(
        children: [
          BaseAppBar(
            prefix: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const SizedBox.square(
                dimension: 40,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 24,
                  color: AppColors.colorDescription,
                ),
              ),
            ),
            content: Column(
              children: [
                const DescriptionText("Employees"),
                const SizedBox(height: 4),
                TitleText(widget.menuSection.name),
              ],
            ),
          )
        ],
      ),
    );
  }
}
