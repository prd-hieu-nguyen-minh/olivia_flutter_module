class Employee {
  final dynamic name;
  final dynamic jobTitle;
  final dynamic department;
  final dynamic managers;
  final dynamic location;
  final dynamic annualSalary;
  final dynamic annualSalaryCurrency;
  final dynamic birthday;
  final dynamic candidateApplicationId;
  final dynamic userRole;
  final dynamic employeeId;
  final dynamic workEmail;
  final dynamic workCountry;

  Employee({
    this.name,
    this.jobTitle,
    this.department,
    this.managers,
    this.location,
    this.annualSalary,
    this.annualSalaryCurrency,
    this.birthday,
    this.candidateApplicationId,
    this.userRole,
    this.employeeId,
    this.workEmail,
    this.workCountry,
  });

  factory Employee.fromJson(Map? json) {
    return Employee(
      name: json?["name"],
      jobTitle: json?["position_title"],
      department: json?[""],
      managers: json?[""],
      location: json?[""],
      annualSalary: json?[""],
      annualSalaryCurrency: json?[""],
      birthday: json?[""],
      candidateApplicationId: json?[""],
      userRole: json?["user_role"],
      workEmail: json?["work_email"],
    );
  }

  Map<String, dynamic> get map => {
        "name": name,
        "job_title": jobTitle,
        "user_role": userRole,
        "work_email": workEmail,
        "work_country": workCountry,
      };
}
