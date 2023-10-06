import 'dart:async';

import 'package:flutter/services.dart';

class SampleCallNativeFlutter {
  static const MethodChannel _channel = MethodChannel('sample_plugin_flutter');
  static const MethodChannel _menuChannel = MethodChannel("menu_channel");

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Map<dynamic, dynamic>?> get headers async {
    final headers = await _channel.invokeMethod('headers');
    return headers;
  }

  static Future<String?> get companyId async {
    final companyId = await _channel.invokeMethod('companyId');
    return companyId?.toString();
  }

  static Future showMenuMore(String menuJson) async {
    await _menuChannel.invokeMethod('show_more', menuJson);
  }
}