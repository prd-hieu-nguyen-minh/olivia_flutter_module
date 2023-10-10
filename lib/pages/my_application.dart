import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/pages/calendars/my_calendar_page.dart';
import 'package:olivia_flutter_module/pages/candidate_management/candidate_management_page.dart';
import 'package:olivia_flutter_module/pages/employees/employees_page.dart';
import 'package:olivia_flutter_module/pages/unknowns/unknown_route_page.dart';

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: chooseWidget(PlatformDispatcher.instance.defaultRouteName),
      ),
    );
  }

  Widget chooseWidget(String? route) {
    switch (route) {
      case "candidate_management":
        return const CandidateManagementPage();
      case "my_calendar":
        return const MyCalendarPage();
      case "employees":
        return const EmployeesPage();
      default:
        return UnknownRoutePage(
          route: route ?? "unknown",
        );
    }
  }
}
