import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_bloc.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_state.dart';
import 'package:olivia_flutter_module/core/models/candidates/column.dart' as Col;
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/core/models/toobar/export_toolbar.dart';
import 'package:olivia_flutter_module/core/models/toobar/icon_toolbar.dart';
import 'package:olivia_flutter_module/core/models/toobar/search_toolbar.dart';
import 'package:olivia_flutter_module/pages/employees/widgets/employee_section_widget.dart';
import 'package:olivia_flutter_module/pages/widgets/base/base_board_main_page.dart';
import 'package:olivia_flutter_module/pages/widgets/disable_scroll_grow_behavior.dart';
import 'package:olivia_flutter_module/pages/widgets/toolbar_widget.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  late EmployeeBloc _employeeBloc;
  late ValueNotifier<MenuSection?> _currentMenuNotifier;
  late Map<int, ScrollController> _horScrollControllerMap;
  late ScrollController _employeesScrollController;

  @override
  void initState() {
    _employeeBloc = EmployeeBloc();
    _currentMenuNotifier = ValueNotifier(null);
    _horScrollControllerMap = {};
    _employeesScrollController = ScrollController();
    _employeeBloc.getNavigation();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _employeeBloc.getNavigation();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _employeesScrollController.dispose();
    _currentMenuNotifier.dispose();
    for (var controller in _horScrollControllerMap.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBoardMainPage(
      title: _buildTitle(),
      mainBoard: _buildMainBoard(),
      content: ScrollConfiguration(
        behavior: DisableScrollGrowBehavior(),
        child: _buildContent(),
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

  Widget _buildMainBoard() {
    return BlocConsumer(
      bloc: _employeeBloc,
      listenWhen: (previous, current) {
        return current is GetNavigationEmployeeSuccess;
      },
      listener: (context, state) {
        if (state is GetNavigationEmployeeSuccess) {
          if (state.menuSections.isNotEmpty) {
            updateCurrentMenu(state.menuSections.first);
          }
        }
      },
      buildWhen: (previous, current) {
        return _currentMenuNotifier.value == null || current is GetNavigationEmployeeSuccess;
      },
      builder: (context, state) {
        if (state is InProgressState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GetNavigationEmployeeSuccess) {
          return ValueListenableBuilder<MenuSection?>(
            valueListenable: _currentMenuNotifier,
            builder: (_, currentMenu, __) {
              return ListView.builder(
                itemCount: state.menuSections.length,
                itemBuilder: (context, index) {
                  MenuSection menuSection = state.menuSections[index];
                  return EmployeeSectionWidget(
                    menuSection: menuSection,
                    isCurrent: menuSection == currentMenu,
                    onSelected: updateCurrentMenu,
                  );
                },
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
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
            SearchToolbar(),
            IconToolbar(
              icon: Icons.dashboard_customize,
            ),
            ExportToolbar(),
          ],
        ),
      ],
    );
  }

  Widget _buildEmployeeListView() {
    return BlocBuilder(
      bloc: _employeeBloc,
      builder: (context, state) {
        if (state is InProgressState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GetEmployeesSuccess) {
          return _buildListView(
              columns: state.response.getColumns(),
              records: state.response.employees.map((e) => e.map).toList());
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildListView({
    required List<Col.Column> columns,
    required List<Map<String, dynamic>> records,
  }) {
    return Scrollbar(
      controller: _employeesScrollController,
      child: ListView.builder(
        controller: _employeesScrollController,
        itemCount: records.length + 1,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var horScrollController = _horScrollControllerMap[index] ?? ScrollController();
          _horScrollControllerMap.putIfAbsent(index, () => horScrollController);
          horScrollController.addListener(() {
            getHorScrollListener(horScrollController);
          });
          if (index == 0) {
            return Row(
              children: [
                _buildItem(
                  columns.first.text,
                  isTitle: true,
                ),
                Flexible(
                  child: SingleChildScrollView(
                    controller: horScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: columns
                          .sublist(1, columns.length)
                          .map((e) => _buildItem(
                                e.text,
                                isTitle: true,
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            );
          }
          return Row(
            children: [
              _buildItem(records[index - 1][columns.first.id]?.toString() ?? ""),
              Flexible(
                child: SingleChildScrollView(
                  controller: horScrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: columns
                        .sublist(1, columns.length)
                        .map((c) => _buildItem(records[index - 1][c.id]?.toString() ?? ""))
                        .toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildItem(String text, {isTitle = false}) {
    return SizedBox(
      width: 180,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: isTitle ? FontWeight.w700 : FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void updateCurrentMenu(MenuSection menuSection) {
    if (_currentMenuNotifier.value != menuSection) {
      _currentMenuNotifier.value = menuSection;
      _employeeBloc.getEmployees(menuSection);
    }
  }

  void getHorScrollListener(ScrollController controller) {
    for (var c in _horScrollControllerMap.values) {
      if (c != controller && c.hasClients && c.offset != controller.offset) {
        c.jumpTo(controller.offset);
      }
    }
  }
}
