import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/pages/widgets/main_loading_indicator.dart';

mixin LoadingMixin<T extends StatefulWidget> on State<T> {
  bool _showedLoading = false;

  void showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        _showedLoading = true;
        return const Dialog(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          child: MainLoadingIndicator(),
        );
      },
    );
  }

  void hideLoading() {
    if (_showedLoading) {
      Navigator.of(context).pop();
    }
    _showedLoading = false;
  }

  void executeTask(Future Function() task) async {
    try {
      showLoading();
      await task.call();
    } finally {
      hideLoading();
    }
  }
}
