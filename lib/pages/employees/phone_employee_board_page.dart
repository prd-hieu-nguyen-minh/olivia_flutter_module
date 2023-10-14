import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/pages/employees/phone_employee_content_page.dart';
import 'package:olivia_flutter_module/pages/employees/widgets/employee_main_board_widget.dart';
import 'package:olivia_flutter_module/pages/widgets/app_bar/all_app_bar.dart';
import 'package:olivia_flutter_module/pages/widgets/base/base_page.dart';

class PhoneEmployeeBoardPage extends StatefulWidget {
  const PhoneEmployeeBoardPage({super.key});

  @override
  State<PhoneEmployeeBoardPage> createState() => _PhoneEmployeeBoardPageState();
}

class _PhoneEmployeeBoardPageState extends State<PhoneEmployeeBoardPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: const AllAppBar(
        title: 'Employees',
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
