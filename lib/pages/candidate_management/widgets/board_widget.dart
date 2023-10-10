import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:olivia_flutter_module/core/helpers/app_helpers.dart';
import 'package:olivia_flutter_module/core/models/menu_section.dart';
import 'package:olivia_flutter_module/pages/widgets/menu_section_widget.dart';
import 'package:olivia_flutter_module/services/api_services.dart';

class BoardWidget extends StatefulWidget {
  const BoardWidget({Key? key}) : super(key: key);

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  final menuMethodChannel = const MethodChannel("flutter_menu_channel");

  late List<MenuSection> menuData;
  late ApiServices apiServices;

  @override
  void initState() {
    menuData = [];
    apiServices = ApiServices();
    menuMethodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "menu_more_result":
          {
            var text = call.arguments.toString();
            Fluttertoast.showToast(
              msg: text,
              toastLength: Toast.LENGTH_SHORT,
            );
          }
          break;
      }
    });
    getCandidateInbox();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: menuData.length,
      itemBuilder: (context, index) => MenuSectionWidget(
        menuSection: menuData[index],
      ),
    );
  }

  void getCandidateInbox() async {
    var menuSection = await apiServices.getCandidateInbox();
    var menuData = AppHelpers.getMenuData(menuSection);
    setState(() {
      this.menuData = menuData;
    });
  }

  void showConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Show dialog"),
        content: const Text("Is this really dialog?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }
}
