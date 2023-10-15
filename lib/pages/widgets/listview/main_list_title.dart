import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';
import 'package:olivia_flutter_module/core/resources/app_images.dart';
import 'package:olivia_flutter_module/data/models/candidates/column.dart' as cl;
import 'package:olivia_flutter_module/data/enums/sort_by.dart';
import 'package:olivia_flutter_module/pages/widgets/listview/main_list_item.dart';

class MainListTitle extends StatelessWidget {
  final cl.Column column;
  final void Function(SortBy? sortBy)? onTap;

  const MainListTitle({
    Key? key,
    required this.column,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SortBy? sortBy;
        switch (column.sortBy) {
          case null:
            sortBy = SortBy.asc;
            break;
          case SortBy.asc:
            sortBy = SortBy.desc;
            break;
          case SortBy.desc:
            break;
        }
        onTap?.call(sortBy);
      },
      child: MainListItem(
        text: column.text,
        isTitle: true,
        suffix: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(
              isDown: false,
              isSelect: column.sortBy == SortBy.asc,
            ),
            const SizedBox(height: 3),
            _buildIcon(
              isDown: true,
              isSelect: column.sortBy == SortBy.desc,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon({
    required bool isDown,
    required bool isSelect,
  }) {
    return RotatedBox(
      quarterTurns: isDown ? 0 : 90,
      child: SvgPicture.asset(
        AppImages.icArrowDown,
        colorFilter: ColorFilter.mode(
          isSelect ? AppColors.colorText : AppColors.colorDescription,
          BlendMode.srcIn,
        ),
        height: 6,
        width: 6,
      ),
    );
  }
}
