import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../core/resources/app_colors.dart';

class MainLoadingIndicator extends StatelessWidget {
  const MainLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: LoadingIndicator(
          indicatorType: Indicator.ballScaleMultiple,
          strokeWidth: 2,
          colors: [
            AppColors.colorPrimary,
          ],
        ),
      ),
    );
  }
}
