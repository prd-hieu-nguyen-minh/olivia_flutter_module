import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_state.dart';
import 'package:olivia_flutter_module/data/models/candidates/column.dart';
import 'package:olivia_flutter_module/data/models/menu_section.dart';
import 'package:olivia_flutter_module/di/injection.dart';
import 'package:olivia_flutter_module/repositories/employee_repository.dart';

class EmployeeBloc extends BaseBloc with SingleBlocMixin {
  final EmployeeRepository _employeeRepository;

  EmployeeBloc() : _employeeRepository = getIt<EmployeeRepository>();

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
    int perPage = 30,
    Column? column,
  }) {
    single(
      () => _employeeRepository.getEmployees({
        "employee_type": menuSection.key,
        "filter_data": menuSection.filterData,
        "keyword": keyword,
        "page": page,
        "per_page": perPage,
        "sort": column?.sortMap ?? {},
      }),
      onSuccess: (data) {
        data.column = column;
        return GetEmployeesSuccess(
          response: data,
        );
      },
    );
  }
}
