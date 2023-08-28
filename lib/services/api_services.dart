import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:olivia_flutter_module/core/contants/api_contants.dart';
import 'package:olivia_flutter_module/core/helpers/app_helpers.dart';
import 'package:olivia_flutter_module/core/models/CandidateResponse.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/main.dart';

class ApiServices {
  final client = Dio();

  Future<MenuSection?> getCandidateInbox() async {
    try {
      var headers = (await SampleCallNativeFlutter.headers)?.map(
        (key, value) => MapEntry(key.toString(), value.toString()),
      );
      var response = await client.get(
        "${ApiConstants.ltsstgApiUrl}/settings/menu/candidate-inbox",
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        return MenuSection.fromJson(response.data);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<CandidateResponse?> getCandidates() async {
    try {
      var headers = (await SampleCallNativeFlutter.headers)?.map(
        (key, value) => MapEntry(key.toString(), value.toString()),
      );
      var response = await client.patch(
        "${ApiConstants.ltsstgApiUrl}/cem/candidate/get-candidates",
        data: jsonEncode(AppHelpers.candidateResponseBody),
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        return CandidateResponse.fromJson(response.data);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
