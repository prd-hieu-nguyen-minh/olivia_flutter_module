import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/data/models/employees/employee_response.dart';
import 'package:olivia_flutter_module/data/models/menu_section.dart';

class GetNavigationEmployeeSuccess extends BaseState {
  final List<MenuSection> menuSections;

  GetNavigationEmployeeSuccess({
    required this.menuSections,
  });
}

class GetEmployeesSuccess extends BaseState {
  final EmployeeResponse response;

  GetEmployeesSuccess({
    required this.response,
  });
}
