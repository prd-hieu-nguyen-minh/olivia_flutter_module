import 'dart:ui' as wd;

import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/pages/candidate_management/candidate_management_page.dart';
import 'package:olivia_flutter_module/pages/my_calendar_page.dart';
import 'package:olivia_flutter_module/pages/unknown_route_page.dart';

export 'src/src.dart';

void main() {
  runApp(getApplication(wd.window.defaultRouteName));
}

Widget getApplication(String? route) {
  return MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      fontFamily: 'OpenSans',
      primarySwatch: Colors.blue,
    ),
    home: Scaffold(
      body: chooseWidget(route),
    ),
  );
}

Widget chooseWidget(String? route) {
  switch (route) {
    case "candidate_management":
      return const CandidateManagementPage();
    case "my_calendar":
      return const MyHomePage();
    default:
      return UnknownRoutePage(
        route: route ?? "unknown",
      );
  }
}
