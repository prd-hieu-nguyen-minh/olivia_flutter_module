import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/enums/sort_by.dart';
import 'package:olivia_flutter_module/core/models/candidates/column.dart' as cl;
import 'package:olivia_flutter_module/core/resources/app_colors.dart';
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
          children: [
            _buildIcon(
              Icons.arrow_drop_up_outlined,
              isSelect: column.sortBy == SortBy.asc,
            ),
            const SizedBox(height: 2),
            _buildIcon(
              Icons.arrow_drop_down_outlined,
              isSelect: column.sortBy == SortBy.desc,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(
    IconData iconData, {
    required bool isSelect,
  }) {
    return Icon(
      iconData,
      color: isSelect ? AppColors.colorText : AppColors.colorDescription,
      size: 20,
    );
  }
}
