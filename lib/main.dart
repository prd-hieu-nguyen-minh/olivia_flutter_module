import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/di/injection.dart';
import 'package:olivia_flutter_module/pages/my_application.dart';

export 'src/src.dart';

void main() async {
  await configureDependencies();

  runApp(const MyApplication());
}
