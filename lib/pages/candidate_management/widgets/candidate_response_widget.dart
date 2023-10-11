import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/models/CandidateResponse.dart';
import 'package:olivia_flutter_module/pages/candidate_management/widgets/candidate_toolbar_widget.dart';

class CandidateResponseWidget extends StatefulWidget {
  final CandidateResponse? response;

  const CandidateResponseWidget({
    Key? key,
    required this.response,
  }) : super(key: key);

  @override
  State<CandidateResponseWidget> createState() =>
      _CandidateResponseWidgetState();
}

class _CandidateResponseWidgetState extends State<CandidateResponseWidget> {
  late ScrollController horizontalScrollBar;
  late ScrollController verticalScrollBar;

  @override
  void initState() {
    horizontalScrollBar = ScrollController();
    verticalScrollBar = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    horizontalScrollBar.dispose();
    verticalScrollBar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CandidateToolBarWidget(
          total: widget.response?.total ?? 0,
        ),
        Expanded(
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildContent() {
    var columns = widget.response?.columns ?? [];
    if (columns.isEmpty) {
      return const SizedBox.shrink();
    }
    return Scrollbar(
      controller: horizontalScrollBar,
      child: SingleChildScrollView(
        controller: horizontalScrollBar,
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Row(
              children: columns
                  .map((e) => _buildItem(
                        e.text,
                        isTitle: true,
                      ))
                  .toList(),
            ),
            Flexible(
              child: Scrollbar(
                controller: verticalScrollBar,
                child: SingleChildScrollView(
                  controller: verticalScrollBar,
                  child: Column(
                    children:
                        (widget.response?.candidates ?? []).map((candidate) {
                      var candidateMap = candidate.map;
                      return Row(
                        children: (widget.response?.columns ?? [])
                            .map((column) =>
                                _buildItem(candidateMap[column.id] ?? ""))
                            .toList(),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String text, {isTitle = false}) {
    return SizedBox(
      width: 180,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: isTitle ? FontWeight.w700 : FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
