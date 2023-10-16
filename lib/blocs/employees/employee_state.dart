import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/data/models/employees/employee.dart';
import 'package:olivia_flutter_module/data/models/menu_section.dart';

import '../../data/models/candidates/column.dart';

class GetNavigationEmployeeSuccess extends BaseState {
  final List<MenuSection> menuSections;

  GetNavigationEmployeeSuccess({
    required this.menuSections,
  });
}

class GetEmployeesSuccess extends BaseState {
  final List<Employee> employees;
  final List<Column> columns;
  final bool isHasNext;
  final int page;
  final Column? sortColumn;

  GetEmployeesSuccess({
    required this.employees,
    required this.columns,
    required this.isHasNext,
    required this.page,
    this.sortColumn,
  });
}
