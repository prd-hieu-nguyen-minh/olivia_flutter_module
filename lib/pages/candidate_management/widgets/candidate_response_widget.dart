import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/models/CandidateResponse.dart';
import 'package:olivia_flutter_module/pages/candidate_management/widgets/toolbar_widget.dart';

class CandidateResponseWidget extends StatefulWidget {
  final CandidateResponse? response;

  const CandidateResponseWidget({
    Key? key,
    required this.response,
  }) : super(key: key);

  @override
  State<CandidateResponseWidget> createState() => _CandidateResponseWidgetState();
}

class _CandidateResponseWidgetState extends State<CandidateResponseWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToolBarWidget(
          total: widget.response?.total ?? 0,
        ),
        Expanded(
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Table(
      children: [
        TableRow(
          children: widget.response?.columns
                  .map((column) => Text(
                        column.text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ))
                  .toList() ??
              [],
        ),
        ...(widget.response?.candidates ?? []).map((candidate) {
          var candidateMap = candidate.map;
          return TableRow(
            children: (widget.response?.columns ?? [])
                .map((column) => Text(
                      candidateMap[column.id] ?? "",
                    ))
                .toList(),
          );
        }).toList(),
      ],
    );
  }
}
