import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_bloc.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_state.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';
import 'package:olivia_flutter_module/data/models/employees/employee.dart';
import 'package:olivia_flutter_module/di/injection.dart';
import 'package:olivia_flutter_module/main.dart';
import 'package:olivia_flutter_module/ui/pages/employees/widgets/employee_profile_header.dart';
import 'package:olivia_flutter_module/ui/widgets/base/base_page.dart';

class EmployeeDetailPage extends StatefulWidget {
  const EmployeeDetailPage({super.key});

  @override
  State<EmployeeDetailPage> createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage> {
  late MethodChannel _employeeDetailChannel;
  late EmployeeBloc _employeeBloc;
  late ValueNotifier<bool> _loadingNotifier;

  @override
  void initState() {
    _employeeDetailChannel = const MethodChannel("employees.detail.channel");
    _employeeBloc = getIt<EmployeeBloc>();
    _loadingNotifier = ValueNotifier(true);
    super.initState();
  }

  @override
  void dispose() {
    _loadingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      loadingNotifier: _loadingNotifier,
      body: FutureBuilder<String?>(
        future: _employeeDetailChannel.invokeMethod("employees.detail.record_json"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map args = jsonDecode(snapshot.data ?? "") ?? {};
            var currentOffset = args["current_offset"] ?? 0;
            getEmployeeDetail(
              employeeId: args["employee_id"],
              args: args,
            );
            return _buildBlocConsumer(currentOffset, args);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildBlocConsumer(
    int currentOffset,
    Map args,
  ) {
    return BlocConsumer(
      listener: (context, state) {
        _loadingNotifier.value = state is InProgressState;
      },
      bloc: _employeeBloc,
      buildWhen: (previous, current) => current is GetEmployeeDetailSuccess,
      builder: (context, state) {
        if (state is GetEmployeeDetailSuccess) {
          return Column(
            children: [
              EmployeeProfileHeader(
                position: currentOffset,
                count: state.employeeDetail.totalEmployees,
                isFirst: currentOffset <= 1,
                isLast: state.employeeDetail.nextEmployeeId == 0,
                onPrevious: (prePosition) {
                  currentOffset = prePosition;
                  getEmployeeDetail(
                    employeeId: state.employeeDetail.prevEmployeeId,
                    args: args,
                  );
                },
                onNext: (nextPosition) {
                  currentOffset = nextPosition;
                  getEmployeeDetail(
                    employeeId: state.employeeDetail.nextEmployeeId,
                    args: args,
                  );
                },
              ),
              const Divider(
                color: AppColors.colorLineBar,
                height: 1,
                thickness: 1,
              ),
              _buildEmployeeInfo(state.employeeDetail.about),
              Expanded(
                child: _buildContent(state.employeeDetail.about),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildEmployeeInfo(Employee employee) {
    return Container(
      color: AppColors.colorBgInfo,
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: AppColors.colorBgAvatar,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: FutureBuilder(
                // TODO (Hieu Nguyen Minh): Write getFirstCharString in dart later
                future: SampleCallNativeFlutter.getFirstCharString(employee.name),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.data ?? employee.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employee.name.toString(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                employee.jobTitle.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // TODO (Hieu Nguyen Minh): Handle later
  Widget _buildContent(Employee employee) {
    return const Placeholder();
  }

  void closeDialog() async {
    await _employeeDetailChannel.invokeMethod("employees.detail.close_dialog");
  }

  void getEmployeeDetail({
    required employeeId,
    required Map args,
  }) {
    _employeeBloc.getEmployeeDetail(
      employeeId: employeeId,
      keyword: args["filter"]?["keyword"],
      sort: args["filter"]?["sort"],
    );
  }
}
