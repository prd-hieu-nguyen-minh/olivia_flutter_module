import 'package:flutter/material.dart';

class MainListItem extends StatelessWidget {
  final String text;
  final Widget? suffix;
  final bool isTitle;

  const MainListItem({
    Key? key,
    required this.text,
    this.suffix,
    this.isTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: suffix == null
            ? _buildText()
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildText(),
                  const SizedBox(width: 8),
                  suffix!,
                ],
              ),
      ),
    );
  }

  Widget _buildText() {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: isTitle ? FontWeight.w700 : FontWeight.w400,
        fontSize: 16,
      ),
    );
  }
}
