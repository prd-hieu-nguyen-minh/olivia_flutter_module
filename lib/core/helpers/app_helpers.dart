import 'package:olivia_flutter_module/core/models/menu_section.dart';

class AppHelpers {
  static String menuJsonStr = '''
{
  "key": 2,
  "name": "Candidates",
  "children": [
    {
      "is_hidden": 0,
      "key": 11,
      "name": "Action Needed"
    },
    {
      "is_hidden": 0,
      "key": 16,
      "name": "All Candidates"
    },
    {
      "id": 11328,
      "name": "Delete all",
      "folder_type": "",
      "type": 0,
      "is_segment": true,
      "created_by": 266805,
      "visible_creator_only": false,
      "is_hidden": null,
      "key": 51
    },
    {
      "id": 2881,
      "name": "Remote - Da Nang Segment",
      "folder_type": "",
      "type": 0,
      "is_segment": true,
      "created_by": 266805,
      "visible_creator_only": false,
      "is_hidden": 0,
      "key": 51
    },
    {
      "key": 3,
      "name": "More",
      "children": [
        {
          "is_hidden": 0,
          "key": 23,
          "name": "Referred By"
        },
        {
          "is_hidden": 0,
          "key": 24,
          "name": "Spam"
        },
        {
          "is_hidden": 0,
          "key": 25,
          "name": "Incomplete"
        },
        {
          "is_hidden": 1,
          "key": 26,
          "name": "Unsubscribed"
        },
        {
          "is_hidden": 1,
          "key": 17,
          "name": "View by Stage"
        },
        {
          "is_hidden": 1,
          "key": 18,
          "name": "View by Job"
        },
        {
          "is_hidden": 1,
          "key": 22,
          "name": "View by Location"
        },
        {
          "is_hidden": 1,
          "key": 28,
          "name": "Candidate Care"
        },
        {
          "is_hidden": 1,
          "key": 27,
          "name": "View by Source"
        },
        {
          "is_hidden": 1,
          "key": 30,
          "name": "Candidate Care Onboarding"
        },
        {
          "is_hidden": 1,
          "key": 29,
          "name": "Employee Care"
        },
        {
          "is_hidden": 1,
          "key": 31,
          "name": "Employee Care Onboarding"
        },
        {
          "is_hidden": 1,
          "key": 32,
          "name": "Job Search"
        },
        {
          "is_hidden": 1,
          "key": 33,
          "name": "Start Keywords"
        }
      ]
    }
  ],
  "success": true
}
      ''';

  static List<MenuSection> getMenuData(MenuSection? menuSection) {
    List<MenuSection> result = [];
    if (menuSection == null) {
      return result;
    }
    result.add(menuSection);
    for (var child in menuSection.children) {
      child.parent = menuSection;
      result.addAll(getMenuData(child));
    }
    return result;
  }
}
