import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/ui/widgets/toolbar/toolbar_item.dart';

class ToolbarWidget extends StatelessWidget {
  final List<Widget> toolbars;
  final void Function(dynamic key)? onTap;

  const ToolbarWidget({
    super.key,
    required this.toolbars,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (var i = 0; i < toolbars.length; i++) {
      var toolbar = toolbars[i]; // as ToolbarItem?;
      if (toolbar is ToolbarItem) {
        widgets.add(InkWell(
          onTap: () {
            onTap?.call(toolbar.toolbarKey);
          },
          child: toolbar,
        ));
      } else {
        widgets.add(toolbar);
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
