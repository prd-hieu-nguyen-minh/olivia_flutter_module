import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/di/injection.dart';
import 'package:olivia_flutter_module/main.dart';

class BuildConfig {
  static BuildConfig? _instance;

  BuildConfig? get instance => _instance;

  BuildConfig._();

  static Future initialize() async {
    if (_instance == null) {
      debugPrint("_instanceabc $abc ${_instance.hashCode}");
      abc = true;
      _instance = BuildConfig._();
      await configureDependencies();
    }
  }
}
