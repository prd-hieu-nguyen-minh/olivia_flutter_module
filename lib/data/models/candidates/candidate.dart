class Candidate {
  final String name;
  final String phoneNumber;
  final String email;
  final String candidateJobApplied;
  final String location;
  final String journeyStatusName;
  final String age;
  final String jobShift;
  final String scheduledAt;
  final String createdAt;

  Candidate({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.candidateJobApplied,
    required this.location,
    required this.journeyStatusName,
    required this.age,
    required this.jobShift,
    required this.scheduledAt,
    required this.createdAt,
  });

  factory Candidate.fromJson(Map? json) {
    return Candidate(
      name: json?["name"] ?? "",
      phoneNumber: json?["phone_number"] ?? "",
      email: json?["email"] ?? "",
      candidateJobApplied: json?["candidate_job_applied"] ?? "",
      location: json?["location"] ?? "",
      journeyStatusName: json?["journey_status_name"] ?? "",
      age: json?["age"] ?? "",
      jobShift: json?["job_shift"] ?? "",
      scheduledAt: json?["scheduled_at"] ?? "",
      createdAt: json?["created_at"] ?? "",
    );
  }

  Map<String, String> get map => {
        "name": name,
        "phone_number": phoneNumber.isNotEmpty ? phoneNumber : "_",
        "email": email,
        "candidate_job_applied": candidateJobApplied,
        "location": location,
        "journey_status_name": journeyStatusName,
        "age": age,
        "job_shift": jobShift,
        "scheduled_at": scheduledAt,
        "created_at": createdAt,
      };
}
