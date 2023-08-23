import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/helpers/app_helpers.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/pages/candidate_management/widgets/board_widget.dart';
import 'package:olivia_flutter_module/utils/app_utils.dart';

class CandidateManagementPage extends StatefulWidget {
  const CandidateManagementPage({super.key});

  @override
  State<CandidateManagementPage> createState() => _CandidateManagementPageState();
}

class _CandidateManagementPageState extends State<CandidateManagementPage> {
  final double globalSpace = 14;

  MenuSection? menuSection = null;

  @override
  void initState() {
    menuSection = AppUtils.parseMenuSectionFromJson(AppHelpers.menuJsonStr);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(globalSpace),
      child: Row(
        children: [
          SizedBox(
            width: 250,
            child: menuSection != null
                ? BoardWidget(menuSection: menuSection!)
                : const SizedBox.shrink(),
          ),
          SizedBox(width: globalSpace),
          Expanded(
            child: _buildContent(),
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
