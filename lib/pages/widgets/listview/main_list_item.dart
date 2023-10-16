import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: suffix == null
                  ? _buildText()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildText(),
                        const SizedBox(width: 8),
                        suffix!,
                      ],
                    ),
            ),
          ),
          const Divider(
            color: AppColors.colorDescription,
            height: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildText() {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: isTitle ? FontWeight.w700 : FontWeight.w400,
        fontSize: 16,
      ),
    );
  }
}
