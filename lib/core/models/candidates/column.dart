class Column {
  final String id;
  final String text;

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
}
