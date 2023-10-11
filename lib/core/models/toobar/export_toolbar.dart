import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/models/toobar/toolbar.dart';
import 'package:olivia_flutter_module/pages/widgets/main_border_widget.dart';

class ExportToolbar extends Toolbar {
  @override
  Widget getWidget() {
    return const MainBorderWidget(
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
