import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/pages/widgets/main_border_widget.dart';

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
            width: 250,
            child: MainBorderWidget(
              child: board,
            ),
          ),
          SizedBox(width: mainSpace),
          Expanded(
            child: MainBorderWidget(
              child: content,
            ),
          ),
        ],
      ),
    );
  }
}
