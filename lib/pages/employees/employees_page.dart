import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/pages/employees/widgets/employee_main_board.dart';
import 'package:olivia_flutter_module/pages/widgets/base/base_board_main_page.dart';
import 'package:olivia_flutter_module/pages/widgets/main_border_widget.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  @override
  Widget build(BuildContext context) {
    return BaseBoardMainPage(
      title: _buildTitle(),
      mainBoard: const EmployeeMainBoard(),
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

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "All employees",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _buildToolBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildToolBar() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "35 employees",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 8),
        const MainBorderWidget(
          radius: 4,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.filter_list_sharp,
              color: Colors.black87,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 8),
        _buildSearchBar(),
        const SizedBox(width: 8),
        const MainBorderWidget(
          radius: 4,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.dashboard_customize,
              color: Colors.black87,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 8),
        const MainBorderWidget(
          radius: 4,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(
                  Icons.cloud_download_outlined,
                  color: Colors.black87,
                  size: 24,
                ),
                SizedBox(width: 2),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black12,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return const MainBorderWidget(
      radius: 4,
      child: SizedBox(
        width: 200,
        height: 40,
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.black26,
              size: 20,
            ),
            SizedBox(width: 4),
            Expanded(
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.black38,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
