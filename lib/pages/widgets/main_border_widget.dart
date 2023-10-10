import 'package:flutter/material.dart';

class MainBorderWidget extends StatelessWidget {
  final Widget child;
  final double radius;

  const MainBorderWidget({
    super.key,
    required this.child,
    this.radius = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black26,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
