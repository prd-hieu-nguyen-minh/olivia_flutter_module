import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/data/models/menu_section.dart';

import '../../../widgets/section_widget.dart';

class EmployeeSectionWidget extends StatelessWidget {
  final MenuSection menuSection;
  final bool isCurrent;
  final void Function(MenuSection menuSection)? onSelected;

  const EmployeeSectionWidget({
    Key? key,
    required this.menuSection,
    required this.isCurrent,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected?.call(menuSection),
      child: SectionWidget(
        content: Text(
          menuSection.name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        suffix: Text(
          menuSection.count.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        isCurrent: isCurrent,
      ),
    );
  }
}
