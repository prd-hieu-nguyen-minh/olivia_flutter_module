import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';
import 'package:olivia_flutter_module/core/resources/app_images.dart';
import 'package:olivia_flutter_module/pages/widgets/main_border.dart';
import 'package:olivia_flutter_module/pages/widgets/text/normal_text_16.dart';

class DesktopHeaderApp extends StatelessWidget {
  final void Function()? onAllAppTap;

  const DesktopHeaderApp({
    super.key,
    this.onAllAppTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TODO: App bar not center
        const SizedBox(height: 6),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildAllAppIcon(),
                const SizedBox(width: 15),
                _buildLogoApp(),
                const Spacer(),
                _buildCompanyInfo(),
              ],
            ),
          ),
        ),
        const Divider(
          thickness: 1,
          color: AppColors.colorLineBar,
        ),
      ],
    );
  }

  Widget _buildAllAppIcon() {
    return InkWell(
      onTap: () => onAllAppTap?.call(),
      child: MainBorder(
        radius: 4,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              SvgPicture.asset(
                AppImages.icAllApp,
              ),
              const SizedBox(width: 4),
              const NormalText16("All Apps"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoApp() {
    return SvgPicture.asset(AppImages.icParadoxLogo);
  }

  Widget _buildCompanyInfo() {
    return Row(
      children: [
        const NormalText16("ParadoxVN - Hieu: Mobile"),
        const SizedBox(width: 8),
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: AppColors.colorText,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              "PT",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
