import 'package:olivia_flutter_module/core/models/candidates/column.dart';
import 'package:olivia_flutter_module/core/models/employees/employee.dart';

class EmployeeResponse {
  final List<Employee> employees;
  Column? column;

  EmployeeResponse({
    required this.employees,
    this.column,
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

  List<Column> getColumns() {
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
    if (column?.sortBy != null) {
      for (var cl in result) {
        if (cl.id == column?.id) {
          cl.sortBy = column?.sortBy;
          return result;
        }
      }
    }
    return result;
  }
}
