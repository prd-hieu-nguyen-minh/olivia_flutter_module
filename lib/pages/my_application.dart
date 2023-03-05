import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/pages/my_calendar_page.dart';
import 'package:olivia_flutter_module/pages/unknown_route_page.dart';

class MyApplication extends StatelessWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: chooseWidget(window.defaultRouteName),
    );
  }

  Widget chooseWidget(String route) {
    switch (route) {
      case "my_calendar":
        return const MyCalendarPage();
      default:
        return const UnknownRoutePage();
    }
  }
}
