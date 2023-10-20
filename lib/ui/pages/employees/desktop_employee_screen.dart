import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/main.dart';

import '../../widgets/app_bar/desktop/desktop_header_app.dart';
import '../../widgets/app_bar/desktop/desktop_header_toolbar.dart';
import '../../widgets/base/base_page.dart';
import 'employees_page.dart';

class DesktopEmployeeScreen extends StatefulWidget {
  const DesktopEmployeeScreen({super.key});

  @override
  State<DesktopEmployeeScreen> createState() => _DesktopEmployeeScreenState();
}

class _DesktopEmployeeScreenState extends State<DesktopEmployeeScreen> {
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
