import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/ui/widgets/text/description_text.dart';

class NoDataWidget extends StatelessWidget {
  final Widget icon;
  final String text;

  const NoDataWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        const SizedBox(height: 12),
        DescriptionText(text),
      ],
    );
  }
}
