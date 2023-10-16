import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/extensions/bool_extension.dart';
import 'package:olivia_flutter_module/data/enums/sort_by.dart';
import 'package:olivia_flutter_module/data/models/candidates/column.dart' as cl;
import 'package:olivia_flutter_module/pages/widgets/listview/main_list_item.dart';
import 'package:olivia_flutter_module/pages/widgets/listview/main_list_title.dart';

class MainListView extends StatefulWidget {
  final List<cl.Column> columns;
  final List<Map<String, dynamic>> records;
  final int pingCount;
  final Widget noDataWidget;
  final bool isHasNext;
  final void Function()? onLoadMore;
  final void Function(cl.Column column, SortBy? sortBy)? onTitleTap;

  const MainListView({
    Key? key,
    required this.columns,
    required this.records,
    this.pingCount = 0,
    this.onTitleTap,
    this.isHasNext = false,
    this.onLoadMore,
    required this.noDataWidget,
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
    return Column(
      children: [
        _buildRecordRow(
          columns: widget.columns,
          pingCount: widget.pingCount,
          index: -1,
          builder: (column) => MainListTitle(
            column: column,
            onTap: (sortBy) {
              widget.onTitleTap?.call(column, sortBy);
            },
          ),
        ),
        Expanded(
          child: widget.records.isNotEmpty
              ? Scrollbar(
                  controller: _lvScrollController,
                  child: ListView.builder(
                    controller: _lvScrollController,
                    itemCount: widget.records.length + widget.isHasNext.toInt(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index == widget.records.length) {
                        widget.onLoadMore?.call();
                        return const SizedBox(height: 2);
                      }
                      return _buildRecordRow(
                        columns: widget.columns,
                        pingCount: widget.pingCount,
                        index: index,
                        builder: (column) => MainListItem(
                          text: widget.records[index][column.id]?.toString() ??
                              "",
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: SingleChildScrollView(
                    child: widget.noDataWidget,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildRecordRow({
    required List<cl.Column> columns,
    required int pingCount,
    required int index,
    required Widget Function(cl.Column column) builder,
  }) {
    var horScrollController =
        _childScrollControllerMap[index] ?? ScrollController();
    _childScrollControllerMap.putIfAbsent(index, () => horScrollController);
    horScrollController.addListener(() {
      getHorScrollListener(horScrollController);
    });
    return Row(
      children: [
        Row(
          children:
              columns.sublist(0, pingCount).map((e) => builder(e)).toList(),
        ),
        Flexible(
          child: SingleChildScrollView(
            controller: horScrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: columns
                  .sublist(pingCount, columns.length)
                  .map((e) => builder(e))
                  .toList(),
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
