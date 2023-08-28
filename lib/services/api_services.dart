import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:olivia_flutter_module/core/contants/api_contants.dart';
import 'package:olivia_flutter_module/core/helpers/app_helpers.dart';
import 'package:olivia_flutter_module/core/models/CandidateResponse.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/main.dart';
import 'package:olivia_flutter_module/utils/app_utils.dart';

class ApiServices {
  Future<MenuSection?> getCandidateInbox() async {
    try {
      var url = Uri.parse(
          "${ApiConstants.ltsstgApiUrl}/settings/menu/candidate-inbox");
      var headers = (await SampleCallNativeFlutter.headers)?.map(
        (key, value) => MapEntry(key.toString(), value.toString()),
      );
      var response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        return AppUtils.parseMenuSectionFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<CandidateResponse?> getCandidates() async {
    try {
      var url = Uri.parse("${ApiConstants.ltsstgApiUrl}/cem/candidate/get-candidates");
      var headers = (await SampleCallNativeFlutter.headers)?.map(
            (key, value) => MapEntry(key.toString(), value.toString()),
      );
      // headers?.putIfAbsent("content-type", () => "application/x-www-form-urlencoded");
      var response = await http.patch(
        url,
        headers: headers,
        body: json.encode(AppHelpers.candidateResponseBody),
      );
      if (response.statusCode == 200) {
        return CandidateResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
