import 'package:flutter/material.dart';

enum MenuType {
  CANDIDATE,
  MORE,
  ACTION_NEEDED,
  INBOX,
  ALL_CANDIDATES,
  REFERRED_BY,
  SPAM,
  INCOMPLETE,
  UNSUBSCRIBED,
  SEGMENT;

  int get key {
    switch (this) {
      case MenuType.CANDIDATE:
        return 2;
      case MenuType.MORE:
        return 3;
      case MenuType.ACTION_NEEDED:
        return 11;
      case MenuType.INBOX:
        return 12;
      case MenuType.ALL_CANDIDATES:
        return 16;
      case MenuType.REFERRED_BY:
        return 23;
      case MenuType.SPAM:
        return 24;
      case MenuType.INCOMPLETE:
        return 25;
      case MenuType.UNSUBSCRIBED:
        return 26;
      case MenuType.SEGMENT:
        return 51;
    }
  }

  IconData? get icon {
    switch (this) {
      case MenuType.MORE:
        return Icons.more_horiz;
      case MenuType.ACTION_NEEDED:
        return Icons.info;
      case MenuType.INBOX:
      case MenuType.ALL_CANDIDATES:
        return Icons.groups;
      case MenuType.REFERRED_BY:
        return Icons.star;
      case MenuType.SPAM:
        return Icons.do_not_disturb_alt;
      case MenuType.INCOMPLETE:
        return Icons.incomplete_circle;
      case MenuType.UNSUBSCRIBED:
        return Icons.unsubscribe;
      case MenuType.SEGMENT:
        return Icons.segment;
    }
  }
}
