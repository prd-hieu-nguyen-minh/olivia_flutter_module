import 'package:flutter/material.dart';

class MainListItem extends StatelessWidget {
  final String text;
  final bool isTitle;

  const MainListItem({
    Key? key,
    required this.text,
    this.isTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: isTitle ? FontWeight.w700 : FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
