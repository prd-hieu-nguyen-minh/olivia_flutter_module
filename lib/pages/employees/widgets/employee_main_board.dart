import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_bloc.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_state.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';

import 'employee_section_widget.dart';

class EmployeeMainBoard extends StatefulWidget {
  final void Function(MenuSection menuSection)? onMenuSelected;

  const EmployeeMainBoard({
    super.key,
    this.onMenuSelected,
  });

  @override
  State<EmployeeMainBoard> createState() => _EmployeeMainBoardState();
}

class _EmployeeMainBoardState extends State<EmployeeMainBoard> {
  late EmployeeBloc _employeeBloc;
  late ValueNotifier<int> currentMenuIndexNotifier;

  @override
  void initState() {
    _employeeBloc = EmployeeBloc();
    currentMenuIndexNotifier = ValueNotifier(0);
    _employeeBloc.getNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _employeeBloc.getNavigation();
    return BlocBuilder(
      bloc: _employeeBloc,
      builder: (context, state) {
        if (state is InProgressState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GetNavigationEmployeeSuccess) {
          var menuSections = state.menuSections;
          if (menuSections.isNotEmpty) {
            widget.onMenuSelected?.call(menuSections[currentMenuIndexNotifier.value]);
          }
          return ValueListenableBuilder<int>(
            valueListenable: currentMenuIndexNotifier,
            builder: (_, currentIndex, __) {
              return ListView.builder(
                itemCount: state.menuSections.length,
                itemBuilder: (context, index) {
                  MenuSection menuSection = state.menuSections[index];
                  return EmployeeSectionWidget(
                    menuSection: menuSection,
                    isCurrent: currentIndex == index,
                    onSelected: (menuSection) {
                      widget.onMenuSelected?.call(menuSection);
                      currentMenuIndexNotifier.value = index;
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
}
