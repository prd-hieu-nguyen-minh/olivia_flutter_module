import 'dart:ui' as wd;

import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/pages/my_calendar_page.dart';
import 'package:olivia_flutter_module/pages/talent_community/talent_community_page.dart';
import 'package:olivia_flutter_module/pages/unknown_route_page.dart';

void main() {
  runApp(getApplication(wd.window.defaultRouteName));
}

Widget getApplication(String route) {
  return MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: Scaffold(
      body: chooseWidget(route),
    ),
  );
}

Widget chooseWidget(String route) {
  switch (route) {
    case "talent_community":
      return const TalentCommunityPage();
    case "my_calendar":
      return const MyHomePage();
    default:
      return const UnknownRoutePage();
  }
}
