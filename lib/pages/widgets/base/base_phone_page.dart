import 'package:flutter/material.dart';

class BasePhonePage extends StatelessWidget {
  final Widget body;

  const BasePhonePage({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: body,
    );
  }
}
