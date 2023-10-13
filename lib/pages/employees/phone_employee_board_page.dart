import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';
import 'package:olivia_flutter_module/core/resources/app_images.dart';
import 'package:olivia_flutter_module/pages/employees/phone_employee_content_page.dart';
import 'package:olivia_flutter_module/pages/employees/widgets/employee_main_board_widget.dart';
import 'package:olivia_flutter_module/pages/widgets/base/base_page.dart';
import 'package:olivia_flutter_module/pages/widgets/main_border.dart';
import 'package:olivia_flutter_module/pages/widgets/text/title_text.dart';

class PhoneEmployeeBoardPage extends StatefulWidget {
  const PhoneEmployeeBoardPage({super.key});

  @override
  State<PhoneEmployeeBoardPage> createState() => _PhoneEmployeeBoardPageState();
}

class _PhoneEmployeeBoardPageState extends State<PhoneEmployeeBoardPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: MainBorder(
            radius: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(AppImages.icAllApp),
            ),
          ),
        ),
        title: const TitleText("Employees"),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: AppColors.colorLineBar,
          ),
        ),
        elevation: 0,
      ),
      body: EmployeeMainBoardWidget(
        onMenuSelected: goToContent,
      ),
    );
  }

  void goToContent(MenuSection menuSection) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PhoneEmployeeContentPage(
        menuSection: menuSection,
      ),
    ));
  }
}
