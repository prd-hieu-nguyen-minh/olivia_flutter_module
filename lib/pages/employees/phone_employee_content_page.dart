import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olivia_flutter_module/blocs/blocs.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_bloc.dart';
import 'package:olivia_flutter_module/blocs/employees/employee_state.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/core/resources/app_colors.dart';
import 'package:olivia_flutter_module/di/injection.dart';
import 'package:olivia_flutter_module/pages/widgets/base/base_phone_page.dart';
import 'package:olivia_flutter_module/pages/widgets/listview/main_list_view.dart';
import 'package:olivia_flutter_module/pages/widgets/main_loading_indicator.dart';
import 'package:olivia_flutter_module/pages/widgets/text/description_text.dart';
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

  @override
  void initState() {
    _employeeBloc = getIt<EmployeeBloc>();
    _employeeBloc.getEmployees(widget.menuSection);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePhonePage(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
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
        title: Column(
          children: [
            const DescriptionText("Employees"),
            const SizedBox(height: 4),
            TitleText(widget.menuSection.name),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.filter_list,
              color: AppColors.colorText,
            ),
          ),
        ],
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: AppColors.colorLineBar,
          ),
        ),
      ),
      body: _buildEmployeeListView(),
    );
  }

  Widget _buildEmployeeListView() {
    return BlocBuilder(
      bloc: _employeeBloc,
      builder: (context, state) {
        if (state is InProgressState) {
          return const MainLoadingIndicator();
        }
        if (state is GetEmployeesSuccess) {
          return MainListView(
            columns: state.response.getColumns(),
            records: state.response.employees.map((e) => e.map).toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
