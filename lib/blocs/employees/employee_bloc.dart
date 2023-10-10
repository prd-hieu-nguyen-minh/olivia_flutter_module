import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_state.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/repositories/employee_repository.dart';

class EmployeeBloc extends BaseBloc with SingleBlocMixin {
  final EmployeeRepository _employeeRepository;

  EmployeeBloc() : _employeeRepository = EmployeeRepositoryImpl();

  void getNavigation() async {
    single<List<MenuSection>>(
      () => _employeeRepository.getNavigation(),
      onSuccess: (data) => GetNavigationEmployeeSuccess(
        menuSections: data,
      ),
    );
  }
}
