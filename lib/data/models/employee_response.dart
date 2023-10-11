import 'package:olivia_flutter_module/core/models/candidates/column.dart';
import 'package:olivia_flutter_module/core/models/candidates/employee.dart';

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

  List<Column> getColumns() {
    return [
      Column(
        id: "name",
        text: "name",
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
    ];
  }
}
