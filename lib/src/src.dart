import 'dart:async';

import 'package:flutter/services.dart';

class SampleCallNativeFlutter {
  static const MethodChannel _channel = MethodChannel('common_channel');
  static const MethodChannel _menuChannel = MethodChannel("menu_channel");

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<Map<String, String>?> get headers async {
    final headers = (await _channel.invokeMethod('headers')) as Map?;
    return headers?.map(
      (key, value) => MapEntry(key.toString(), value.toString()),
    );
  }

  static Future<String?> get apiUrl async {
    final url = await _channel.invokeMethod("api_url");
    return url;
  }

  static Future<String?> get companyId async {
    final companyId = await _channel.invokeMethod('companyId');
    return companyId?.toString();
  }

  static Future<bool?> showAllApp() async {
    return await _channel.invokeMethod("show_all_app");
  }

  static Future showMenuMore(String menuJson) async {
    await _menuChannel.invokeMethod('show_more', menuJson);
  }

  static Future<String?> getFirstCharString(String name) async {
    return await _channel.invokeMethod("get_first_char_string", name);
  }

  static Future showDialogFromNative(Map params) {
    return _channel.invokeMethod("show_dialog_from_native", params);
  }
}
