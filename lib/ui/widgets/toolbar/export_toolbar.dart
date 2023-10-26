import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/ui/widgets/toolbar/toolbar_item.dart';

import '../main_border.dart';

class ExportToolbar extends ToolbarItem {
  const ExportToolbar({
    super.key,
    required super.toolbarKey,
  });

  @override
  Widget build(BuildContext context) {
    return const MainBorder(
      radius: 4,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(
              Icons.cloud_download_outlined,
              color: Colors.black87,
              size: 24,
            ),
            SizedBox(width: 2),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black26,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
