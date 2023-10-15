import 'package:dio/dio.dart';
import 'package:olivia_flutter_module/data/models/employees/employee_response.dart';
import 'package:olivia_flutter_module/data/models/menu_section.dart';
import 'package:olivia_flutter_module/data/sources/remote/service/dio_client.dart';
import 'package:olivia_flutter_module/di/injection.dart';
import 'package:olivia_flutter_module/src/src.dart';

const EMPLOYEE_SETTING_URL = "settings/employees";

abstract class EmployeeRemoteDataSource {
  Future<List<MenuSection>> getNavigation();

  Future<EmployeeResponse> getEmployees(Map<String, dynamic> params);
}

class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  final DioService _dioService;

  EmployeeRemoteDataSourceImpl() : _dioService = getIt<DioService>();

  @override
  Future<List<MenuSection>> getNavigation() async {
    final headers = (await SampleCallNativeFlutter.headers)?.map(
      (key, value) => MapEntry(key.toString(), value.toString()),
    );
    final response = await _dioService.get(
      '$EMPLOYEE_SETTING_URL/navigation',
      options: Options(
        headers: headers,
      ),
    );
    return (response as List? ?? []).map((e) {
      return MenuSection.fromJson(e);
    }).toList();
  }

  @override
  Future<EmployeeResponse> getEmployees(Map<String, dynamic> params) async {
    final headers = (await SampleCallNativeFlutter.headers)?.map(
      (key, value) => MapEntry(key.toString(), value.toString()),
    );
    final response = await _dioService.post(
      '$EMPLOYEE_SETTING_URL/search',
      data: params,
      options: Options(
        headers: headers,
      ),
    );
    return EmployeeResponse.fromJson(response?["data"]);
  }
}
