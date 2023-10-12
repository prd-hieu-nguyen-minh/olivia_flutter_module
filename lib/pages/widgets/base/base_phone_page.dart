import 'package:flutter/material.dart';

class BasePhonePage extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;

  const BasePhonePage({
    super.key,
    required this.body,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      body: body,
    );
  }
}
