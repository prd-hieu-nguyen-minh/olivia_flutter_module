import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/data/sources/remote/datasources/employee_remote_datasource.dart';
import 'package:olivia_flutter_module/repositories/repositories.dart';

abstract class EmployeeRepository extends BaseRepository {
  Future<List<MenuSection>> getNavigation();
}

class EmployeeRepositoryImpl implements EmployeeRepository {
  final EmployeeRemoteDataSource _employeeRemoteDataSource;

  EmployeeRepositoryImpl()
      : _employeeRemoteDataSource = EmployeeRemoteDataSourceImpl();

  @override
  Future<List<MenuSection>> getNavigation() {
    return _employeeRemoteDataSource.getNavigation();
  }
}
