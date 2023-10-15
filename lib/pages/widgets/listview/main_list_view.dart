import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/data/enums/sort_by.dart';
import 'package:olivia_flutter_module/data/models/candidates/column.dart' as cl;
import 'package:olivia_flutter_module/pages/widgets/listview/main_list_item.dart';
import 'package:olivia_flutter_module/pages/widgets/listview/main_list_title.dart';

class MainListView extends StatefulWidget {
  final List<cl.Column> columns;
  final List<Map<String, dynamic>> records;
  final int pingCount;
  final void Function(cl.Column column, SortBy? sortBy)? onTitleTap;

  const MainListView({
    Key? key,
    required this.columns,
    required this.records,
    this.pingCount = 0,
    this.onTitleTap,
  }) : super(key: key);

  @override
  State<MainListView> createState() => _MainListViewState();
}

class _MainListViewState extends State<MainListView> {
  late ScrollController _lvScrollController;
  late Map<int, ScrollController> _childScrollControllerMap;

  @override
  void initState() {
    _lvScrollController = ScrollController();
    _childScrollControllerMap = {};
    super.initState();
  }

  @override
  void dispose() {
    _lvScrollController.dispose();
    for (var controller in _childScrollControllerMap.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _lvScrollController,
      child: ListView.builder(
        controller: _lvScrollController,
        itemCount: widget.records.length + 1,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var horScrollController = _childScrollControllerMap[index] ?? ScrollController();
          _childScrollControllerMap.putIfAbsent(index, () => horScrollController);
          horScrollController.addListener(() {
            getHorScrollListener(horScrollController);
          });
          if (index == 0) {
            return _buildRecordRow(
              columns: widget.columns,
              pingCount: widget.pingCount,
              builder: (column) => MainListTitle(
                column: column,
                onTap: (sortBy) {
                  widget.onTitleTap?.call(column, sortBy);
                },
              ),
              horScrollController: horScrollController,
            );
          }
          return _buildRecordRow(
            columns: widget.columns,
            pingCount: widget.pingCount,
            builder: (column) => MainListItem(
              text: widget.records[index - 1][column.id]?.toString() ?? "",
            ),
            horScrollController: horScrollController,
          );
        },
      ),
    );
  }

  Widget _buildRecordRow({
    required List<cl.Column> columns,
    required int pingCount,
    required Widget Function(cl.Column column) builder,
    required ScrollController horScrollController,
  }) {
    return Row(
      children: [
        Row(
          children: columns.sublist(0, pingCount).map((e) => builder(e)).toList(),
        ),
        Flexible(
          child: SingleChildScrollView(
            controller: horScrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: columns.sublist(pingCount, columns.length).map((e) => builder(e)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  void getHorScrollListener(ScrollController controller) {
    for (var c in _childScrollControllerMap.values) {
      if (c != controller && c.hasClients && c.offset != controller.offset) {
        c.jumpTo(controller.offset);
      }
    }
  }
}
