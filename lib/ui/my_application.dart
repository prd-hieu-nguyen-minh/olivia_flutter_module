import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/ui/pages/employees/employee_detail_page.dart';

import 'pages/calendars/my_calendar_page.dart';
import 'pages/candidate_management/candidate_management_page.dart';
import 'pages/employees/desktop_employee_screen.dart';
import 'pages/employees/employees_page.dart';
import 'pages/employees/phone_employee_board_page.dart';
import 'pages/unknowns/unknown_route_page.dart';

class MyApplication extends StatelessWidget {
  final String? router;

  const MyApplication({super.key, this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: chooseWidget(router ?? PlatformDispatcher.instance.defaultRouteName),
      ),
    );
  }

  Widget chooseWidget(String? route) {
    switch (route) {
      case "candidate_management":
        return const CandidateManagementPage();
      case "my_calendar":
        return const MyCalendarPage();
      // Employees
      case "desktop_employees_screen":
        return const DesktopEmployeeScreen();
      case "desktop_employees":
        return const EmployeesPage();
      case "phone_employees":
        return const PhoneEmployeeBoardPage();
      case "employee_detail_page":
        return const EmployeeDetailPage();
      default:
        return UnknownRoutePage(
          route: route ?? "unknown",
        );
    }
  }
}
