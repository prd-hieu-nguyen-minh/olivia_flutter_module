import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/data/models/toobar/toolbar.dart';

class ToolbarWidget extends StatelessWidget {
  final List<Widget> toolbars;
  final void Function(dynamic key)? callBack;

  const ToolbarWidget({
    super.key,
    required this.toolbars,
    this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (var i = 0; i < toolbars.length; i++) {
      var t = toolbars[i]; // as ToolbarItem?;
      if (t is ToolbarItem) {
        widgets.add(InkWell(
          onTap: () {
            callBack?.call(t?.toolbarKey);
          },
          child: t,
        ));
      } else {
        widgets.add(toolbars[i]);
      }
      if (i != toolbars.length - 1) {
        widgets.add(const SizedBox(width: 8));
      }
    }
    return Row(
      children: widgets,
    );
  }
}
