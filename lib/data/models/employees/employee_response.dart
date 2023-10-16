import 'package:olivia_flutter_module/data/models/candidates/column.dart';
import 'package:olivia_flutter_module/data/models/employees/employee.dart';

class EmployeeResponse {
  final List<Employee> employees;

  EmployeeResponse({
    required this.employees,
  });

  factory EmployeeResponse.fromJson(Map? json) {
    var employees = (json?["employees"] as List? ?? [])
        .map(
          (e) => Employee.fromJson(e),
        )
        .toList();
    return EmployeeResponse(
      employees: employees,
    );
  }

  List<Column> getColumns(Column? sortColumn) {
    var result = [
      Column(
        id: "name",
        text: "Name",
      ),
      Column(
        id: "position_title",
        text: "Job Title",
      ),
      Column(
        id: "user_role",
        text: "User Role",
      ),
      Column(
        id: "work_email",
        text: "Work Email",
      ),
      Column(
        id: "work_country",
        text: "Work Country",
      ),
      Column(
        id: "preferred_language",
        text: "Preferred Language",
      ),
    ];
    if (sortColumn?.sortBy != null) {
      for (var cl in result) {
        if (cl.id == sortColumn?.id) {
          cl.sortBy = sortColumn?.sortBy;
          return result;
        }
      }
    }
    return result;
  }
}
