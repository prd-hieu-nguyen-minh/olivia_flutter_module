import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/common/utils/utils.dart';
import 'package:olivia_flutter_module/data/enums/menu_type.dart';
import 'package:olivia_flutter_module/data/models/menu_section.dart';
import 'package:olivia_flutter_module/main.dart';

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
    var menuType = Utils.getMenuTypeFromKey(menuSection.key);
    if (menuType == null) {
      return const SizedBox.shrink();
    }
    if (menuType == MenuType.CANDIDATE) {
      return _buildAllCandidate(menuSection.name);
    }
    return _buildMenuItemWidget(
      menuSection: menuSection,
      iconData: menuType.icon,
      isMore: menuSection.isMore,
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
    required MenuSection menuSection,
    IconData? iconData,
    bool isMore = false,
  }) {
    var isChildMore = menuSection.parent?.isMore ?? false;
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
            menuSection.name,
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
        InkWell(
          onTap: () => showMenuMore(menuSection),
          child: Icon(
            isMore ? Icons.keyboard_arrow_up : Icons.more_vert,
            size: 20,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  void showMenuMore(MenuSection menuSection) async {
    await SampleCallNativeFlutter.showMenuMore(jsonEncode(menuSection.map));
  }
}
