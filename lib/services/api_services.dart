import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:olivia_flutter_module/core/contants/api_contants.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/utils/app_utils.dart';

class ApiServices {
  Future<MenuSection?> getCandidateInbox() async {
    try {
      var url = Uri.parse("${ApiConstants.ltsstgApiUrl}/settings/menu/candidate-inbox");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return AppUtils.parseMenuSectionFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}