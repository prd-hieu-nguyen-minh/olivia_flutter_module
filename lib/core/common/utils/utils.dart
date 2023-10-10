import 'dart:convert';
import 'dart:developer';

import 'package:olivia_flutter_module/core/enums/menu_type.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';

class Utils {
  static MenuSection? parseMenuSectionFromJson(String str) {
    return MenuSection.fromJson(json.decode(str));
  }

  static MenuType? getMenuTypeFromKey(dynamic key) {
    try {
      return MenuType.values.firstWhere((element) => element.key == key);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
