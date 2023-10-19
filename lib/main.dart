import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/di/injection.dart';
import 'package:olivia_flutter_module/pages/my_application.dart';

export 'src/src.dart';

@pragma('vm:entry-point')
void desktopEmployees() async {
  await configureDependencies();
  runApp(const MyApplication(router: "desktop_employees"));
}

@pragma('vm:entry-point')
void phoneEmployees() async {
  await configureDependencies();
  runApp(const MyApplication(router: "phone_employees"));
}

void main() async {
  await configureDependencies();
  runApp(const MyApplication());
}