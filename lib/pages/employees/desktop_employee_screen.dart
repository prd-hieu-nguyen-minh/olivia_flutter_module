import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/pages/employees/employees_page.dart';
import 'package:olivia_flutter_module/pages/widgets/app_bar/desktop/desktop_header_app.dart';
import 'package:olivia_flutter_module/pages/widgets/app_bar/desktop/desktop_header_toolbar.dart';
import 'package:olivia_flutter_module/pages/widgets/base/base_page.dart';

class DesktopEmployeeScreen extends StatelessWidget {
  const DesktopEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BasePage(
      body: Column(
        children: [
          DesktopHeaderApp(),
          DesktopHeaderToolbar(
            title: "Employees",
          ),
          Expanded(
            child: EmployeesPage(),
          ),
        ],
      ),
    );
  }
}
