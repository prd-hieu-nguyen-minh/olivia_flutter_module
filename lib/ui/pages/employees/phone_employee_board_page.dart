import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/data/models/menu_section.dart';
import 'package:olivia_flutter_module/main.dart';
import 'package:olivia_flutter_module/ui/pages/employees/phone_employee_content_page.dart';
import 'package:olivia_flutter_module/ui/pages/employees/widgets/employee_main_board_widget.dart';

import '../../widgets/app_bar/all_app_bar.dart';
import '../../widgets/base/base_page.dart';

class PhoneEmployeeBoardPage extends StatefulWidget {
  const PhoneEmployeeBoardPage({super.key});

  @override
  State<PhoneEmployeeBoardPage> createState() => _PhoneEmployeeBoardPageState();
}

class _PhoneEmployeeBoardPageState extends State<PhoneEmployeeBoardPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AllAppBar(
        title: 'Employees',
        onAllAppTap: gotoAllApp,
      ),
      body: EmployeeMainBoardWidget(
        onMenuSelected: goToContent,
      ),
    );
  }

  void gotoAllApp() async {
    await SampleCallNativeFlutter.showAllApp();
  }

  void goToContent(MenuSection menuSection) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PhoneEmployeeContentPage(
        menuSection: menuSection,
      ),
    ));
  }
}
