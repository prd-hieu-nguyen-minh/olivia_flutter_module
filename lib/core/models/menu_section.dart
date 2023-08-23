import 'package:olivia_flutter_module/core/enums/menu_type.dart';

class MenuSection {
  final int id;
  final String name;
  final int key;
  final bool isSegment;
  final List<MenuSection> children;
  MenuSection? parent;

  MenuSection({
    required this.id,
    required this.name,
    required this.key,
    required this.isSegment,
    this.children = const [],
  });

  factory MenuSection.fromJson(Map<dynamic, dynamic> json) {
    return MenuSection(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      key: json["key"] ?? 0,
      isSegment: json["is_segment"] ?? false,
      children: (json["children"] as List? ?? []).map((e) => MenuSection.fromJson(e)).toList(),
    );
  }

  bool get isMore => key == MenuType.MORE.key;
}
