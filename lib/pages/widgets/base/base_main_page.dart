import 'package:flutter/material.dart';

import '../main_border.dart';

class BaseMainPage extends StatelessWidget {
  final Widget board;
  final Widget content;
  final double mainSpace;

  const BaseMainPage({
    super.key,
    required this.board,
    required this.content,
    required this.mainSpace,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(mainSpace),
      child: Row(
        children: [
          SizedBox(
            width: 300,
            child: MainBorder(
              child: board,
            ),
          ),
          SizedBox(width: mainSpace),
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: MainBorder(
                child: content,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
