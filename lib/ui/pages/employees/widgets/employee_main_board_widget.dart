import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_bloc.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_state.dart';
import 'package:olivia_flutter_module/data/models/menu_section.dart';
import 'package:olivia_flutter_module/di/injection.dart';

import '../../../widgets/main_loading_indicator.dart';
import 'employee_section_widget.dart';

class EmployeeMainBoardWidget extends StatefulWidget {
  final ValueNotifier<MenuSection?>? notifier;
  final void Function(MenuSection menuSection)? onMenuSelected;

  const EmployeeMainBoardWidget({
    super.key,
    this.notifier,
    this.onMenuSelected,
  });

  @override
  State<EmployeeMainBoardWidget> createState() => _EmployeeMainBoardWidgetState();
}

class _EmployeeMainBoardWidgetState extends State<EmployeeMainBoardWidget> {
  late EmployeeBloc _employeeBloc;

  @override
  void initState() {
    _employeeBloc = getIt<EmployeeBloc>();
    _employeeBloc.getNavigation();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EmployeeMainBoardWidget oldWidget) {
    _employeeBloc.getNavigation();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _employeeBloc,
      listenWhen: (previous, current) {
        return current is GetNavigationEmployeeSuccess;
      },
      listener: (context, state) {
        if (state is GetNavigationEmployeeSuccess) {
          if (state.menuSections.isNotEmpty) {
            widget.notifier?.value = state.menuSections.first;
          }
        }
      },
      buildWhen: (previous, current) {
        return widget.notifier?.value == null || current is GetNavigationEmployeeSuccess;
      },
      builder: (context, state) {
        if (state is InProgressState) {
          return const MainLoadingIndicator();
        }
        if (state is GetNavigationEmployeeSuccess) {
          return ValueListenableBuilder<MenuSection?>(
            valueListenable: widget.notifier ?? ValueNotifier(null),
            builder: (_, currentMenu, __) {
              return ListView.builder(
                itemCount: state.menuSections.length,
                itemBuilder: (context, index) {
                  MenuSection menuSection = state.menuSections[index];
                  return EmployeeSectionWidget(
                    menuSection: menuSection,
                    isCurrent: menuSection == currentMenu,
                    onSelected: (menuSection) {
                      widget.onMenuSelected?.call(menuSection);
                      widget.notifier?.value = menuSection;
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
