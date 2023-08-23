import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/enums/menu_type.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/utils/app_utils.dart';

class MenuSectionWidget extends StatelessWidget {
  final MenuSection menuSection;

  const MenuSectionWidget({
    Key? key,
    required this.menuSection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    var menuType = AppUtils.getMenuTypeFromKey(menuSection.key);
    if (menuType == null) {
      return const SizedBox.shrink();
    }
    if (menuType == MenuType.CANDIDATE) {
      return _buildAllCandidate(menuSection.name);
    }
    return _buildMenuItemWidget(
      name: menuSection.name,
      iconData: menuType.icon,
      isMore: menuSection.isMore,
      isChildMore: menuSection.parent?.isMore ?? false,
    );
  }

  Widget _buildAllCandidate(String name) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black26,
      ),
    );
  }

  Widget _buildMenuItemWidget({
    required String name,
    IconData? iconData,
    bool isMore = false,
    bool isChildMore = false,
  }) {
    return Row(
      children: [
        if (isChildMore) const SizedBox(width: 12),
        if (iconData != null)
          Icon(
            iconData,
            size: 18,
            color: Colors.black38,
          ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Icon(
          isMore ? Icons.keyboard_arrow_up : Icons.more_vert,
          size: 20,
          color: Colors.black87,
        ),
      ],
    );
  }
}
