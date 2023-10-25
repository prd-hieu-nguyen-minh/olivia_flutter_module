import 'package:flutter/cupertino.dart';

abstract class Toolbar {
  Widget getWidget();
}

abstract class ToolbarItem extends StatelessWidget {
  final dynamic toolbarKey;
  const ToolbarItem({
    super.key,
    this.toolbarKey,
  });
}

enum ToolbarType {
  FILTER,
  TABLE_SETTING,
  DOWNLOAD;

  int get key {
    switch (this) {
      case ToolbarType.FILTER:
        return 1;
      case ToolbarType.TABLE_SETTING:
        return 2;
      case ToolbarType.DOWNLOAD:
        return 3;
    }
  }
}
