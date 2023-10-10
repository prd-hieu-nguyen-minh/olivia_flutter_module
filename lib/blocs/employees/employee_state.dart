import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';

class GetNavigationEmployeeSuccess extends BaseState {
  final List<MenuSection> menuSections;

  GetNavigationEmployeeSuccess({
    required this.menuSections,
  });
}
