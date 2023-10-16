import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_bloc.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_state.dart';
import 'package:olivia_flutter_module/core/common/utils/debouncer.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';
import 'package:olivia_flutter_module/data/models/candidates/column.dart' as cl;
import 'package:olivia_flutter_module/data/models/menu_section.dart';
import 'package:olivia_flutter_module/data/models/toobar/export_toolbar.dart';
import 'package:olivia_flutter_module/data/models/toobar/icon_toolbar.dart';
import 'package:olivia_flutter_module/data/models/toobar/search_toolbar.dart';
import 'package:olivia_flutter_module/di/injection.dart';
import 'package:olivia_flutter_module/pages/employees/widgets/employee_main_board_widget.dart';
import 'package:olivia_flutter_module/pages/widgets/base/base_board_main_page.dart';
import 'package:olivia_flutter_module/pages/widgets/base/base_page.dart';
import 'package:olivia_flutter_module/pages/widgets/disable_scroll_grow_behavior.dart';
import 'package:olivia_flutter_module/pages/widgets/listview/main_list_view.dart';
import 'package:olivia_flutter_module/pages/widgets/no_data_widget.dart';
import 'package:olivia_flutter_module/pages/widgets/toolbar_widget.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({
    super.key,
  });

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  late EmployeeBloc _employeeBloc;
  late ValueNotifier<MenuSection?> _currentMenuNotifier;
  late DeBouncer _searchDeBouncer;
  late TextEditingController _searchTextController;
  late ValueNotifier<bool> _loadingNotifier;

  @override
  void initState() {
    _employeeBloc = getIt<EmployeeBloc>();
    _currentMenuNotifier = ValueNotifier(null);
    _searchDeBouncer = DeBouncer();
    _searchTextController = TextEditingController();
    _loadingNotifier = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    _currentMenuNotifier.dispose();
    _searchTextController.dispose();
    _loadingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBoardMainPage(
      title: _buildTitle(),
      mainBoard: EmployeeMainBoardWidget(
        notifier: _currentMenuNotifier,
      ),
      content: ScrollConfiguration(
        behavior: DisableScrollGrowBehavior(),
        child: BasePage(
          body: _buildContent(),
          loadingNotifier: _loadingNotifier,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(
            Icons.person,
            color: Colors.black26,
            size: 26,
          ),
          SizedBox(width: 12),
          Text(
            "Employees",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ValueListenableBuilder(
        valueListenable: _currentMenuNotifier,
        builder: (_, value, __) {
          if (value == null) {
            return const SizedBox.shrink();
          }
          getEmployees();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  value.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _buildToolBar(
                  employeeCount: value.count,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: _buildEmployeeListView(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildToolBar({
    required int employeeCount,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "$employeeCount employees",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        ToolbarWidget(
          toolbars: [
            IconToolbar(
              icon: Icons.filter_list_sharp,
            ),
            SearchToolbar(
              textFormField: _buildSearchTextField(),
            ),
            IconToolbar(
              icon: Icons.dashboard_customize,
            ),
            ExportToolbar(),
          ],
        ),
      ],
    );
  }

  TextFormField _buildSearchTextField() {
    return TextFormField(
      controller: _searchTextController,
      maxLines: 1,
      decoration: const InputDecoration(
        isDense: true,
        hintText: "Search",
        hintStyle: TextStyle(
          color: Colors.black38,
          fontSize: 14,
        ),
        border: InputBorder.none,
      ),
      onChanged: (value) {
        _searchDeBouncer.run(() {
          getEmployees();
        });
      },
    );
  }

  Widget _buildEmployeeListView() {
    return BlocConsumer(
      bloc: _employeeBloc,
      listener: (context, state) {
        if (state is InProgressState) {
          _loadingNotifier.value = true;
        } else {
          _loadingNotifier.value = false;
        }
      },
      buildWhen: (previous, current) {
        return current is GetEmployeesSuccess;
      },
      builder: (context, state) {
        if (state is GetEmployeesSuccess) {
          return MainListView(
            columns: state.columns,
            records: state.employees.map((e) => e.map).toList(),
            pingCount: 1,
            isHasNext: state.isHasNext,
            noDataWidget: const NoDataWidget(
              icon: Icon(
                Icons.person,
                color: AppColors.colorDescription,
                size: 60,
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
    var currentMenu = _currentMenuNotifier.value;
    if (currentMenu == null) {
      return;
    }
    _employeeBloc.getEmployees(
      currentMenu,
      keyword: _searchTextController.text,
      sortColumn: sortColumn,
      page: page,
      isRefresh: page == 1,
    );
  }
}
