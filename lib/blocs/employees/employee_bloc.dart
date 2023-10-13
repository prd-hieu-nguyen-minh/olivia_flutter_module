import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_state.dart';
import 'package:olivia_flutter_module/core/models/employees/employee.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/di/injection.dart';
import 'package:olivia_flutter_module/repositories/employee_repository.dart';

class EmployeeBloc extends BaseBloc with SingleBlocMixin {
  final perPage = 30;
  final EmployeeRepository _employeeRepository;
  final List<Employee> _cachedEmployees;

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
  }) {
    _cachedEmployees.clear();
    getMoreEmployees({
      "employee_type": menuSection.key,
      "filter_data": menuSection.filterData,
      "keyword": keyword,
      "page": page,
      "per_page": perPage,
    });
  }

  void getMoreEmployees(Map<String, dynamic> params) {
    single(
      () => _employeeRepository.getEmployees(params),
      onSuccess: (data) {
        _cachedEmployees.addAll(data.employees);
        return GetEmployeesSuccess(
          employees: _cachedEmployees,
          columns: data.getColumns(),
          currentParams: params,
          isHasNext: data.employees.length >= perPage,
        );
      },
    );
  }
}
