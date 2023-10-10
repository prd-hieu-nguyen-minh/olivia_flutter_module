import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_bloc.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_state.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/pages/widgets/menu_section_widget.dart';

class EmployeeMainBoard extends StatefulWidget {
  const EmployeeMainBoard({super.key});

  @override
  State<EmployeeMainBoard> createState() => _EmployeeMainBoardState();
}

class _EmployeeMainBoardState extends State<EmployeeMainBoard> {
  late EmployeeBloc _employeeBloc;

  @override
  void initState() {
    _employeeBloc = EmployeeBloc();
    _employeeBloc.getNavigation();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EmployeeMainBoard oldWidget) {
    _employeeBloc.getNavigation();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _employeeBloc.getNavigation();
    return BlocBuilder(
      bloc: _employeeBloc,
      builder: (context, state) {
        if (state is InProgressState) {
          print("InProgressState");
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GetNavigationEmployeeSuccess) {
          return ListView.builder(
            itemCount: state.menuSections.length,
            itemBuilder: (context, index) {
              MenuSection menuSection = state.menuSections[index];
              return MenuSectionWidget(
                menuSection: menuSection,
              );
            },
          );
        }
        print("SizedBox.shrink");
        return const SizedBox.shrink();
      },
    );
  }
}
