import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/data/models/toobar/toolbar.dart';

class ToolbarWidget extends StatelessWidget {
  final List<Toolbar> toolbars;

  const ToolbarWidget({
    super.key,
    required this.toolbars,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (var i = 0; i < toolbars.length; i++) {
      widgets.add(toolbars[i].getWidget());
      if (i != toolbars.length - 1) {
        widgets.add(const SizedBox(width: 8));
      }
    }
    return Row(
      children: widgets,
    );
  }
}
