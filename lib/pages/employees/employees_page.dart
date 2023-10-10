import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/pages/widgets/base/base_board_main_page.dart';

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
      mainBoard: const SizedBox.shrink(),
      content: const SizedBox.shrink(),
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
}
