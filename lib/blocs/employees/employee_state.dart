import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/data/models/employee_response.dart';

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
