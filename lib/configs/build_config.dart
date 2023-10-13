import 'package:flutter/services.dart';

class BuildConfig {
  static final instance = BuildConfig._();

  BuildConfig._();

  final commonChannel = const MethodChannel("common_channel");

  Future<Map<String, String>?> get headers async {
    final headers = await commonChannel.invokeMethod('headers');
    return headers;
  }

  Future get companySettings async {
    final companySettings = await commonChannel.invokeMethod("company_settings");
    return companySettings;
  }

  Future<bool?> showAllApp() async {
    return await commonChannel.invokeMethod("show_all_app");
  }
}
