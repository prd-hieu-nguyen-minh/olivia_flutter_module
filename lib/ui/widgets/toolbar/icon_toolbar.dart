import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/ui/widgets/toolbar/toolbar_item.dart';

import '../main_border.dart';

class IconToolbar extends ToolbarItem {
  final IconData icon;
  const IconToolbar({
    super.key,
    required this.icon,
    super.toolbarKey,
  });

  @override
  Widget build(BuildContext context) {
    return MainBorder(
      radius: 4,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          color: Colors.black87,
          size: 24,
        ),
      ),
    );
  }
}
