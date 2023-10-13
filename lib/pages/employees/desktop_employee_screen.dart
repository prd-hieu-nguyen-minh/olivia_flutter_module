import 'package:flutter/material.dart';
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
  late ValueNotifier<bool> isAllAppShowedNotifier;

  @override
  void initState() {
    isAllAppShowedNotifier = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    isAllAppShowedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: Column(
        children: [
          DesktopHeaderApp(
            onAllAppTap: showAllApp,
          ),
          const DesktopHeaderToolbar(
            title: "Employees",
          ),
          Expanded(
            child: Stack(
              children: [
                const EmployeesPage(),
                ValueListenableBuilder(
                  valueListenable: isAllAppShowedNotifier,
                  builder: (_, isShow, __) {
                    if (isShow) {
                      return Container(
                        color: Colors.transparent.withOpacity(0.25),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showAllApp() {}
}
