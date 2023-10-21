import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/configs/build_config.dart';
import 'package:olivia_flutter_module/pages/my_application.dart';

export 'src/src.dart';

var abc = false;

@pragma('vm:entry-point')
void desktopEmployees() async {
  await BuildConfig.initialize();
  runApp(const MyApplication(router: "desktop_employees"));
}

@pragma('vm:entry-point')
void phoneEmployees() async {
  await BuildConfig.initialize();
  runApp(const MyApplication(router: "phone_employees"));
}

void main() async {
  await BuildConfig.initialize();
  runApp(const MyApplication());
}
