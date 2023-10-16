import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/data/models/toobar/toolbar.dart';
import 'package:olivia_flutter_module/pages/widgets/main_border.dart';

class IconToolbar extends Toolbar {
  final IconData icon;

  IconToolbar({
    required this.icon,
  });

  @override
  Widget getWidget() {
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
