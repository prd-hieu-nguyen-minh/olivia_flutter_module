import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/pages/widgets/base/base_main_page.dart';

class BaseBoardMainPage extends StatelessWidget {
  final Widget title;
  final Widget mainBoard;
  final Widget content;

  const BaseBoardMainPage({
    super.key,
    required this.title,
    required this.mainBoard,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return BaseMainPage(
      board: Column(
        children: [
          SizedBox(
            height: 80,
            child: title,
          ),
          const Divider(
            color: Colors.black12,
            thickness: 3,
            height: 3,
          ),
          Expanded(
            child: mainBoard,
          ),
        ],
      ),
      content: content,
      mainSpace: 14,
    );
  }
}
