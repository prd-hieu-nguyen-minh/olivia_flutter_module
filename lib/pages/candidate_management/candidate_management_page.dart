import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:olivia_flutter_module/core/models/CandidateResponse.dart';
import 'package:olivia_flutter_module/pages/candidate_management/widgets/board_widget.dart';
import 'package:olivia_flutter_module/pages/candidate_management/widgets/toolbar_widget.dart';
import 'package:olivia_flutter_module/services/api_services.dart';

import '../../core/data/app_colors.dart';
import '../../src/src.dart';

class CandidateManagementPage extends StatefulWidget {
  const CandidateManagementPage({super.key});

  @override
  State<CandidateManagementPage> createState() => _CandidateManagementPageState();
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
    return Padding(
      padding: EdgeInsets.all(globalSpace),
      child: Row(
        children: [
          const SizedBox(
            width: 250,
            child: BoardWidget(),
          ),
          SizedBox(width: globalSpace),
          Expanded(
            child: FutureBuilder<CandidateResponse?>(
              future: apiService.getCandidates(),
              builder: (context, snapshot) {
                return _buildContent(snapshot.data);
              },
            ),
          ),
        ],
      ),
    );
  }

  void abc() async {
    var platform = const MethodChannel("abc");
    platform.setMethodCallHandler(
      (call) async {
        if (call.method == "name") {
          var headers = call.arguments;
          Fluttertoast.showToast(
            msg: headers.toString(),
            toastLength: Toast.LENGTH_LONG,
          );
        }
      },
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
          ToolBarWidget(
            total: candidateResponse?.total ?? 0,
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
}
