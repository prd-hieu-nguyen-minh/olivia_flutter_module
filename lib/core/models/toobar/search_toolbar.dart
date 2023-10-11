import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/models/toobar/toolbar.dart';

class SearchToolbar extends Toolbar {
  @override
  Widget getWidget() {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.black26,
            size: 20,
          ),
          SizedBox(width: 4),
          Expanded(
            child: TextField(
              maxLines: 1,
              decoration: InputDecoration(
                isDense: true,
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 14,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
