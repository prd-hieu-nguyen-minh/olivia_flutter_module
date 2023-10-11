import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_bloc.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_state.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/core/models/toobar/export_toolbar.dart';
import 'package:olivia_flutter_module/core/models/toobar/icon_toolbar.dart';
import 'package:olivia_flutter_module/core/models/toobar/search_toolbar.dart';
import 'package:olivia_flutter_module/pages/employees/widgets/employee_section_widget.dart';
import 'package:olivia_flutter_module/pages/widgets/base/base_board_main_page.dart';
import 'package:olivia_flutter_module/pages/widgets/toolbar_widget.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  late EmployeeBloc _employeeBloc;
  late ValueNotifier<MenuSection?> currentMenuNotifier;

  @override
  void initState() {
    _employeeBloc = EmployeeBloc();
    currentMenuNotifier = ValueNotifier(null);
    super.initState();
  }

  @override
  void dispose() {
    currentMenuNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _employeeBloc.getNavigation();
    return BaseBoardMainPage(
      title: _buildTitle(),
      mainBoard: _buildMainBoard(),
      content: _buildContent(),
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
      listener: (context, state) {
        if (state is GetNavigationEmployeeSuccess) {
          if (state.menuSections.isNotEmpty) {
            currentMenuNotifier.value = state.menuSections.first;
          }
        }
      },
      builder: (context, state) {
        if (state is InProgressState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GetNavigationEmployeeSuccess) {
          return ValueListenableBuilder<MenuSection?>(
            valueListenable: currentMenuNotifier,
            builder: (_, currentMenu, __) {
              return ListView.builder(
                itemCount: state.menuSections.length,
                itemBuilder: (context, index) {
                  MenuSection menuSection = state.menuSections[index];
                  return EmployeeSectionWidget(
                    menuSection: menuSection,
                    isCurrent: menuSection == currentMenu,
                    onSelected: (menuSection) {
                      currentMenuNotifier.value = menuSection;
                    },
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
        valueListenable: currentMenuNotifier,
        builder: (_, value, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  value?.name ?? "",
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
                  employeeCount: value?.count ?? 0,
                ),
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
}
