import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/data/models/toobar/toolbar.dart';

class SearchToolbar extends Toolbar {
  final TextFormField textFormField;

  SearchToolbar({
    required this.textFormField,
  });

  @override
  Widget getWidget() {
    return Container(
      height: 42,
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.black26,
            size: 20,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: textFormField,
          ),
        ],
      ),
    );
  }
}
