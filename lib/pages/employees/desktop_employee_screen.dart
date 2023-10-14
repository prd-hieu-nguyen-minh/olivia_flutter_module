import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/main.dart';
import 'package:olivia_flutter_module/pages/employees/employees_page.dart';
import 'package:olivia_flutter_module/pages/widgets/app_bar/desktop/desktop_header_app.dart';
import 'package:olivia_flutter_module/pages/widgets/app_bar/desktop/desktop_header_toolbar.dart';
import 'package:olivia_flutter_module/pages/widgets/base/base_page.dart';

class DesktopEmployeeScreen extends StatelessWidget {
  const DesktopEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: Column(
        children: [
          DesktopHeaderApp(
            onAllAppTap: showAllAppPopup,
          ),
          const DesktopHeaderToolbar(
            title: "Employees",
          ),
          const Expanded(
            child: EmployeesPage(),
          ),
        ],
      ),
    );
  }

  void showAllAppPopup() async {
    await SampleCallNativeFlutter.showAllApp();
  }
}
