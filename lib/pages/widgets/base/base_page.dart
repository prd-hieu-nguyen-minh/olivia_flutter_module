import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/pages/widgets/main_loading_indicator.dart';

class BasePage extends StatelessWidget {
  final Widget? appBar;
  final Widget body;
  final ValueNotifier<bool>? loadingNotifier;

  const BasePage({
    super.key,
    required this.body,
    this.appBar,
    this.loadingNotifier,
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
              child: Stack(
                children: [
                  body,
                  ValueListenableBuilder(
                      valueListenable: loadingNotifier ?? ValueNotifier(false),
                      builder: (_, showLoading, __) {
                        return Visibility(
                          visible: showLoading,
                          child: const MainLoadingIndicator(),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
