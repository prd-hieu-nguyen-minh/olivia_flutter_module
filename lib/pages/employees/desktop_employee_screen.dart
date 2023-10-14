import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/main.dart';
import 'package:olivia_flutter_module/pages/employees/employees_page.dart';
import 'package:olivia_flutter_module/pages/widgets/app_bar/desktop/desktop_header_app.dart';
import 'package:olivia_flutter_module/pages/widgets/app_bar/desktop/desktop_header_toolbar.dart';
import 'package:olivia_flutter_module/pages/widgets/base/base_page.dart';

class DesktopEmployeeScreen extends StatefulWidget {
  const DesktopEmployeeScreen({super.key});

  @override
  State<DesktopEmployeeScreen> createState() => _DesktopEmployeeScreenState();
}

class _DesktopEmployeeScreenState extends State<DesktopEmployeeScreen> {
  late ValueNotifier<bool> loadingNotifier;

  @override
  void initState() {
    loadingNotifier = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    loadingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      loadingNotifier: loadingNotifier,
      body: Column(
        children: [
          DesktopHeaderApp(
            onAllAppTap: showAllAppPopup,
          ),
          const DesktopHeaderToolbar(
            title: "Employees",
          ),
          Expanded(
            child: EmployeesPage(
              loadingNotifier: loadingNotifier,
            ),
          ),
        ],
      ),
    );
  }

  void showAllAppPopup() async {
    await SampleCallNativeFlutter.showAllApp();
  }
}
