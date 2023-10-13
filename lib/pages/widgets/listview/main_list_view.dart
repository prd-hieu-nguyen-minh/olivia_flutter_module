import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/extensions/bool_extension.dart';
import 'package:olivia_flutter_module/core/models/candidates/column.dart' as cl;
import 'package:olivia_flutter_module/pages/widgets/listview/main_list_item.dart';

class MainListView extends StatefulWidget {
  final List<cl.Column> columns;
  final List<Map<String, dynamic>> records;
  final int pingCount;
  final bool isHasNext;
  final void Function()? onLast;

  const MainListView({
    Key? key,
    required this.columns,
    required this.records,
    this.pingCount = 0,
    this.isHasNext = false,
    this.onLast,
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
        itemCount: widget.records.length + widget.isHasNext.toInt() + 1,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == widget.records.length + 1) {
            widget.onLast?.call();
            return const SizedBox.shrink();
          }
          var horScrollController = _childScrollControllerMap[index] ?? ScrollController();
          _childScrollControllerMap.putIfAbsent(index, () => horScrollController);
          horScrollController.addListener(() {
            getHorScrollListener(horScrollController);
          });
          var isTitle = index == 0;
          return _buildRecordRow(
            pingChildren: widget.columns
                .sublist(0, widget.pingCount)
                .map((column) => MainListItem(
                      text: isTitle
                          ? column.text
                          : widget.records[index - 1][column.id]?.toString() ?? "",
                      isTitle: isTitle,
                    ))
                .toList(),
            scrollChildren: widget.columns
                .sublist(widget.pingCount, widget.columns.length)
                .map((column) => MainListItem(
                      text: isTitle
                          ? column.text
                          : widget.records[index - 1][column.id]?.toString() ?? "",
                      isTitle: isTitle,
                    ))
                .toList(),
            horScrollController: horScrollController,
          );
        },
      ),
    );
  }

  Widget _buildRecordRow({
    required List<Widget> pingChildren,
    required List<Widget> scrollChildren,
    required ScrollController horScrollController,
  }) {
    return Row(
      children: [
        Row(
          children: pingChildren,
        ),
        Flexible(
          child: SingleChildScrollView(
            controller: horScrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: scrollChildren,
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
