import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';
import 'package:olivia_flutter_module/data/models/candidate_response.dart';
import 'package:olivia_flutter_module/pages/candidate_management/widgets/board_widget.dart';
import 'package:olivia_flutter_module/pages/candidate_management/widgets/candidate_response_widget.dart';
import 'package:olivia_flutter_module/pages/widgets/base/base_board_main_page.dart';
import 'package:olivia_flutter_module/services/api_services.dart';

import '../../src/src.dart';

class CandidateManagementPage extends StatefulWidget {
  const CandidateManagementPage({super.key});

  @override
  State<CandidateManagementPage> createState() =>
      _CandidateManagementPageState();
}

class _CandidateManagementPageState extends State<CandidateManagementPage> {
  final double globalSpace = 14;
  final apiService = ApiServices();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBoardMainPage(
      title: _buildTitle(),
      mainBoard: const BoardWidget(),
      content: FutureBuilder<CandidateResponse?>(
        future: apiService.getCandidates(),
        builder: (context, snapshot) {
          return _buildContent(snapshot.data);
        },
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      height: 60,
      child: const Row(
        children: [
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
    );
  }

  Widget _buildContentHeader() {
    return Row(
      children: [
        Expanded(
          child: FutureBuilder(
            future: SampleCallNativeFlutter.platformVersion,
            builder: (context, snapshot) {
              return Text(snapshot.data?.toString() ?? "All Candidatesz");
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.colorPrimary,
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

  Widget _buildContent(CandidateResponse? candidateResponse) {
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
          Expanded(
            child: CandidateResponseWidget(
              response: candidateResponse,
            ),
          ),
        ],
      ),
    );
  }
}
