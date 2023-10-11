import 'package:flutter/material.dart';

class CandidateToolBarWidget extends StatefulWidget {
  final int total;

  const CandidateToolBarWidget({
    Key? key,
    required this.total,
  }) : super(key: key);

  @override
  State<CandidateToolBarWidget> createState() => _CandidateToolBarWidgetState();
}

class _CandidateToolBarWidgetState extends State<CandidateToolBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "${widget.total} Candidates",
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        _buildSearchBar(),
        const SizedBox(width: 8),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.refresh,
            size: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 40,
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.black26,
            size: 20,
          ),
          SizedBox(width: 4),
          Expanded(
            child: TextField(
              maxLines: 1,
              decoration: InputDecoration(
                isDense: true,
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 14,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
