import 'package:olivia_flutter_module/core/models/candidates/candidate.dart';
import 'package:olivia_flutter_module/core/models/candidates/column.dart';

class CandidateResponse {
  final List<Candidate> candidates;
  final List<Column> columns;
  final int total;

  CandidateResponse({
    required this.candidates,
    required this.columns,
    required this.total,
  });

  factory CandidateResponse.fromJson(Map? json) {
    var candidateJson = json?["candidates"] as List? ?? [];
    var columnJson = json?["columns"] as List? ?? [];
    return CandidateResponse(
      candidates: candidateJson.map((e) => Candidate.fromJson(e)).toList(),
      columns: columnJson.map((e) => Column.fromJson(e)).toList(),
      total: json?["total"] ?? 0,
    );
  }
}
