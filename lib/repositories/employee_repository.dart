import 'package:olivia_flutter_module/data/models/employees/employee_detail.dart';
import 'package:olivia_flutter_module/data/models/employees/employee_response.dart';
import 'package:olivia_flutter_module/data/models/menu_section.dart';
import 'package:olivia_flutter_module/data/sources/remote/datasources/employee_remote_datasource.dart';
import 'package:olivia_flutter_module/di/injection.dart';
import 'package:olivia_flutter_module/repositories/repositories.dart';

abstract class EmployeeRepository extends BaseRepository {
  Future<List<MenuSection>> getNavigation();

  Future<EmployeeResponse> getEmployees(Map<String, dynamic> params);

  Future<EmployeeDetail> getEmployeeDetail(Map<String, dynamic> params);
}

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource _employeeRemoteDataSource;

  EmployeeRepositoryImpl() : _employeeRemoteDataSource = getIt<EmployeeRemoteDataSource>();

  @override
  Future<List<MenuSection>> getNavigation() {
    return _employeeRemoteDataSource.getNavigation();
  }

  @override
  Future<EmployeeResponse> getEmployees(Map<String, dynamic> params) {
    return _employeeRemoteDataSource.getEmployees(params);
  }

  @override
  Future<EmployeeDetail> getEmployeeDetail(Map<String, dynamic> params) {
    return _employeeRemoteDataSource.getEmployeeDetail(params);
  }
}
