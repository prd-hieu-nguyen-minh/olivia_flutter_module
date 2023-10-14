import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final Widget? appBar;
  final Widget body;

  const BasePage({
    super.key,
    required this.body,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    var appBar = this.appBar;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            if (appBar != null) appBar,
            Expanded(
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}
