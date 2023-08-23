import 'package:flutter/material.dart';
import 'package:olivia_flutter_module/core/helpers/app_helpers.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/pages/widgets/menu_section_widget.dart';

class BoardWidget extends StatefulWidget {
  final MenuSection menuSection;

  const BoardWidget({
    Key? key,
    required this.menuSection,
  }) : super(key: key);

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  late List<MenuSection> menuData;

  @override
  void initState() {
    menuData = AppHelpers.getMenuData(widget.menuSection);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black26,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _buildHeader(),
          const Divider(
            color: Colors.black12,
            thickness: 3,
            height: 3,
          ),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      height: 60,
      child: Row(
        children: const [
          Expanded(
            child: Text(
              "Candidate Management",
            ),
          ),
          Icon(
            Icons.filter_list,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: menuData.length,
      itemBuilder: (context, index) => MenuSectionWidget(
        menuSection: menuData[index],
      ),
    );
  }
}
