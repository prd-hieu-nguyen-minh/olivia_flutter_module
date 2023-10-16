import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_state.dart';
import 'package:olivia_flutter_module/data/models/candidates/column.dart';
import 'package:olivia_flutter_module/data/models/employees/employee.dart';
import 'package:olivia_flutter_module/data/models/menu_section.dart';
import 'package:olivia_flutter_module/di/injection.dart';
import 'package:olivia_flutter_module/repositories/employee_repository.dart';

class EmployeeBloc extends BaseBloc with SingleBlocMixin {
  final EmployeeRepository _employeeRepository;
  final List<Employee> _cachedEmployees;
  final perPage = 30;

  EmployeeBloc()
      : _employeeRepository = getIt<EmployeeRepository>(),
        _cachedEmployees = [];

  void getNavigation() async {
    single<List<MenuSection>>(
      () => _employeeRepository.getNavigation(),
      onSuccess: (data) => GetNavigationEmployeeSuccess(
        menuSections: data.where((e) => e.count != 0).toList(),
      ),
    );
  }

  void getEmployees(
    MenuSection menuSection, {
    String keyword = "",
    int page = 1,
    Column? sortColumn,
    bool isRefresh = true,
  }) {
    if (isRefresh) {
      _cachedEmployees.clear();
    }
    single(
      () => _employeeRepository.getEmployees({
        "employee_type": menuSection.key,
        "filter_data": menuSection.filterData,
        "keyword": keyword,
        "page": page,
        "per_page": perPage,
        "sort": sortColumn?.sortMap ?? {},
      }),
      onSuccess: (data) {
        _cachedEmployees.addAll(data.employees);
        return GetEmployeesSuccess(
          employees: _cachedEmployees,
          columns: data.getColumns(sortColumn),
          isHasNext: data.employees.length >= perPage,
          page: page,
          sortColumn: sortColumn,
        );
      },
    );
  }
}
