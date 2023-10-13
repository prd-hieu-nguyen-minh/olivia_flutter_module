import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/core/models/candidates/column.dart';
import 'package:olivia_flutter_module/core/models/employees/employee.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/data/models/employee_response.dart';

class GetNavigationEmployeeSuccess extends BaseState {
  final List<MenuSection> menuSections;

  GetNavigationEmployeeSuccess({
    required this.menuSections,
  });
}

class GetEmployeesSuccess extends BaseState {
  final List<Column> columns;
  final List<Employee> employees;
  final Map<String, dynamic> currentParams;
  final bool isHasNext;

  GetEmployeesSuccess({
    required this.employees,
    required this.columns,
    required this.currentParams,
    required this.isHasNext,
  });
}
