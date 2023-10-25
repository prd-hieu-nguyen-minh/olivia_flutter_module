import 'employee.dart';

class EmployeeDetail {
  final Employee about;
  final dynamic accessPermissions;
  final dynamic canViewFullProfile;
  final List? candidateDocuments;
  final List? documents;
  final dynamic nextEmployeeId;
  final dynamic prevEmployeeId;
  final String? timezone;
  final int totalEmployees;

  EmployeeDetail({
    required this.about,
    this.accessPermissions,
    this.canViewFullProfile,
    this.candidateDocuments,
    this.documents,
    this.nextEmployeeId,
    this.prevEmployeeId,
    this.timezone,
    this.totalEmployees = 0,
  });

  factory EmployeeDetail.fromJson(Map? json) {
    return EmployeeDetail(
      about: Employee.fromJson(json?["about"]),
      nextEmployeeId: json?["next_employee_id"],
      prevEmployeeId: json?["prev_employee_id"],
      totalEmployees: json?["total_employees"] ?? 0,
    );
  }
}
