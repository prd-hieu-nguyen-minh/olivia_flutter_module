import 'package:olivia_flutter_module/data/enums/sort_by.dart';

class Column {
  final String id;
  final String text;
  SortBy? sortBy;

  Column({
    required this.id,
    required this.text,
  });

  factory Column.fromJson(Map? json) {
    return Column(
      id: json?["id"] ?? "",
      text: json?["text"] ?? "",
    );
  }

  Map<String, dynamic> get sortMap {
    if (sortBy == null) {
      return {};
    }
    return {
      id: sortBy?.key,
    };
  }
}
