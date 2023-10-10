import 'package:dio/dio.dart';
import 'package:olivia_flutter_module/core/common/constants/url_constant.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/data/sources/remote/service/dio_client.dart';
import 'package:olivia_flutter_module/src/src.dart';

abstract class EmployeeRemoteDataSource {
  Future<List<MenuSection>> getNavigation();
}

class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  final DioService _dioService;

  EmployeeRemoteDataSourceImpl()
      : _dioService = DioService(URLConstant.ltsstgApiUrl, Dio());

  @override
  Future<List<MenuSection>> getNavigation() async {
    final headers = (await SampleCallNativeFlutter.headers)?.map(
      (key, value) => MapEntry(key.toString(), value.toString()),
    );
    final response = await _dioService.get(
      '/settings/employees/navigation',
      options: Options(
        headers: headers,
      ),
    );
    return (response as List?)?.map(
          (e) {
            return MenuSection.fromJson(e);
          },
        ).toList() ??
        [];
  }
}
