class Employee {
  final dynamic id;
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
  final dynamic preferredLanguage;

  Employee({
    this.id,
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
    this.preferredLanguage,
  });

  factory Employee.fromJson(Map? json) {
    return Employee(
      id: json?["id"],
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
      preferredLanguage: json?["preferred_language"],
    );
  }

  Map<String, dynamic> get map => {
        "id": id,
        "name": name,
        "position_title": jobTitle,
        "user_role": userRole,
        "work_email": workEmail,
        "work_country": workCountry,
        "preferred_language": preferredLanguage,
      };
}
