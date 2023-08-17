import 'package:flutter/material.dart';

class TalentCommunityPage extends StatefulWidget {
  const TalentCommunityPage({super.key});

  @override
  State<TalentCommunityPage> createState() => _TalentCommunityPageState();
}

class _TalentCommunityPageState extends State<TalentCommunityPage> {
  final double globalSpace = 14;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(globalSpace),
      child: Row(
        children: [
          SizedBox(
            width: 250,
            child: _buildBoard(),
          ),
          SizedBox(width: globalSpace),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildBoard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black26,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: 60,
            child: Row(
              children: const [
                Expanded(
                  child: Text(
                    "Candidate Management",
                  ),
                ),
                Icon(
                  Icons.filter_list,
                  size: 24,
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black12,
            thickness: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black26,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _buildContentHeader(),
          const SizedBox(height: 8),
          _buildToolBar(),
        ],
      ),
    );
  }

  Widget _buildContentHeader() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "All Candidates",
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            "+ Add Candidates",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToolBar() {
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
              const Text(
                "222 Candidates",
                style: TextStyle(
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
      child: Row(
        children: const [
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
