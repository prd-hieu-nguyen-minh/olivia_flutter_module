import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_bloc.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_state.dart';
import 'package:olivia_flutter_module/core/common/constants/app_channels.dart';
import 'package:olivia_flutter_module/core/extensions/locale_context_extension.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';
import 'package:olivia_flutter_module/core/resources/app_images.dart';
import 'package:olivia_flutter_module/data/models/employees/employee.dart';
import 'package:olivia_flutter_module/di/injection.dart';
import 'package:olivia_flutter_module/main.dart';
import 'package:olivia_flutter_module/ui/pages/employees/widgets/employee_about_widget.dart';
import 'package:olivia_flutter_module/ui/pages/employees/widgets/employee_conversation_widget.dart';
import 'package:olivia_flutter_module/ui/pages/employees/widgets/employee_profile_header.dart';
import 'package:olivia_flutter_module/ui/widgets/base/base_page.dart';
import 'package:olivia_flutter_module/ui/widgets/base/base_profile_widget.dart';

import '../../widgets/tabbar/common_tabbar.dart';

class EmployeeDetailPage extends StatefulWidget {
  const EmployeeDetailPage({super.key});

  @override
  State<EmployeeDetailPage> createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage> with TickerProviderStateMixin {
  late MethodChannel _employeeDetailChannel;
  late EmployeeBloc _employeeBloc;
  late ValueNotifier<bool> _loadingNotifier;
  late TabController _tabController;
  late ValueNotifier<int> _tabNotifier;

  @override
  void initState() {
    _employeeDetailChannel = const MethodChannel(AppChannels.frameChannel);
    _employeeBloc = getIt<EmployeeBloc>();
    _loadingNotifier = ValueNotifier(true);
    _tabNotifier = ValueNotifier(0);
    _tabController = TabController(
      initialIndex: 0,
      length: EmployeeProfileTab.values.length,
      vsync: this,
    )..addListener(() {
        _tabNotifier.value = _tabController.index;
      });
    super.initState();
  }

  @override
  void dispose() {
    _loadingNotifier.dispose();
    _tabNotifier.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      loadingNotifier: _loadingNotifier,
      body: FutureBuilder(
        future: _employeeDetailChannel.invokeMethod(AppChannels.frameChannel_arguments),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map args = snapshot.data as Map? ?? {};
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
                onClose: closeDialog,
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

  Widget _buildContent(Employee employee) {
    return Container(
      color: AppColors.colorBgMainContent,
      padding: const EdgeInsets.only(top: 3),
      child: Row(
        children: [
          SizedBox(
            width: 300,
            child: BaseProfileWidget(
              header: Container(
                alignment: Alignment.center,
                child: const Text("Conversation"),
              ),
              content: const EmployeeConversationWidget(),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: BaseProfileWidget(
              header: _buildEmployeeDetailTab(),
              content: const EmployeeAboutWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildEmployeeDetailTab() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: CommonTabBar(
        controller: _tabController,
        tabs: EmployeeProfileTab.values
            .map(
              (tab) => Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: _tabNotifier,
                    builder: (_, index, __) {
                      return SvgPicture.asset(
                        tab.imagePath,
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          index == tab.index ? AppColors.colorPrimary : AppColors.colorText,
                          BlendMode.srcIn,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(tab.getText(context)),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  void closeDialog() async {
    await _employeeDetailChannel.invokeMethod(AppChannels.frameChannel_closeDialog);
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

enum EmployeeProfileTab {
  about,
  documents;

  String getText(BuildContext context) {
    switch (this) {
      case EmployeeProfileTab.about:
        return context.loc?.about ?? "";
      case EmployeeProfileTab.documents:
        return context.loc?.documents ?? "";
    }
  }

  String get imagePath {
    switch (this) {
      case EmployeeProfileTab.about:
        return AppImages.icAbout;
      case EmployeeProfileTab.documents:
        return AppImages.icDocuments;
    }
  }
}
