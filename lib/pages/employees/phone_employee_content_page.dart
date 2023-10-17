import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_bloc.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_state.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';
import 'package:olivia_flutter_module/data/models/candidates/column.dart' as cl;
import 'package:olivia_flutter_module/data/models/menu_section.dart';
import 'package:olivia_flutter_module/di/injection.dart';
import 'package:olivia_flutter_module/pages/widgets/app_bar/base/base_app_bar.dart';
import 'package:olivia_flutter_module/pages/widgets/base/base_page.dart';
import 'package:olivia_flutter_module/pages/widgets/disable_scroll_grow_behavior.dart';
import 'package:olivia_flutter_module/pages/widgets/listview/main_list_view.dart';
import 'package:olivia_flutter_module/pages/widgets/no_data_widget.dart';
import 'package:olivia_flutter_module/pages/widgets/text/description_text.dart';
import 'package:olivia_flutter_module/pages/widgets/text/normal_text_16.dart';
import 'package:olivia_flutter_module/pages/widgets/text/title_text.dart';

class PhoneEmployeeContentPage extends StatefulWidget {
  final MenuSection menuSection;

  const PhoneEmployeeContentPage({
    super.key,
    required this.menuSection,
  });

  @override
  State<PhoneEmployeeContentPage> createState() => _PhoneEmployeeContentPageState();
}

class _PhoneEmployeeContentPageState extends State<PhoneEmployeeContentPage> {
  late EmployeeBloc _employeeBloc;
  late ValueNotifier<bool> _loadingNotifier;
  late TextEditingController _searchTextController;

  @override
  void initState() {
    _employeeBloc = getIt<EmployeeBloc>();
    _loadingNotifier = ValueNotifier(true);
    _searchTextController = TextEditingController();
    getEmployees();
    super.initState();
  }

  @override
  void dispose() {
    _loadingNotifier.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      loadingNotifier: _loadingNotifier,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearch(),
          const Divider(
            color: AppColors.colorLineBar,
            height: 1,
            thickness: 1,
          ),
          const SizedBox(height: 16),
          _buildEmployeesInfo(),
          const SizedBox(height: 10),
          Expanded(
            child: ScrollConfiguration(
              behavior: DisableScrollGrowBehavior(),
              child: _buildEmployeeListView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return BaseAppBar(
      prefix: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: const SizedBox.square(
          dimension: 40,
          child: Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: AppColors.colorDescription,
          ),
        ),
      ),
      content: Column(
        children: [
          const DescriptionText("Employees"),
          const SizedBox(height: 4),
          TitleText(widget.menuSection.name),
        ],
      ),
      suffix: const Padding(
        padding: EdgeInsets.only(right: 16),
        child: Icon(
          Icons.filter_list,
          color: AppColors.colorText,
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            size: 20,
            color: AppColors.colorDescription,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: _searchTextController,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.colorText,
              ),
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: AppColors.colorDescription,
                ),
              ),
              onChanged: (value) {
                getEmployees();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeesInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: NormalText16("${widget.menuSection.count} employees"),
    );
  }

  Widget _buildEmployeeListView() {
    return BlocConsumer(
      bloc: _employeeBloc,
      listener: (context, state) {
        _loadingNotifier.value = state is InProgressState;
      },
      buildWhen: (previous, current) {
        return current is GetEmployeesSuccess;
      },
      builder: (context, state) {
        if (state is GetEmployeesSuccess) {
          return MainListView(
            columns: state.columns,
            records: state.employees.map((e) => e.map).toList(),
            isHasNext: state.isHasNext,
            noDataWidget: const NoDataWidget(
              icon: Icon(
                Icons.person,
                size: 70,
                color: AppColors.colorDescription,
              ),
              text: "No employees found.",
            ),
            onTitleTap: (column, sortBy) {
              column.sortBy = sortBy;
              getEmployees(
                sortColumn: column,
              );
            },
            onLoadMore: () {
              getEmployees(
                sortColumn: state.sortColumn,
                page: state.page + 1,
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void getEmployees({
    cl.Column? sortColumn,
    int page = 1,
  }) {
    _employeeBloc.getEmployees(
      widget.menuSection,
      keyword: _searchTextController.text,
      sortColumn: sortColumn,
      page: page,
      isRefresh: page == 1,
    );
  }
}
