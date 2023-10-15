import 'package:olivia_flutter_module/data/models/menu_section.dart';

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

  static Map<String, dynamic> get candidateResponseBody => {
        "limit": 30,
        "offset": 60,
        "company_id": 1323,
        "search_keyword": "",
        "order_type": 0,
        "group_by": 99,
        "statuses": null,
        "lead_type": "all-candidates",
        "last_application_id": "7962007",
        "exclude_profile_ids": [
          3670379,
          3669243,
          3667994,
          3669242,
          3669109,
          3657698,
          3657694,
          3622447,
          3606400,
          3604456,
          3604520,
          3604519,
          3576294,
          3579709,
          3558029,
          3576195,
          3575433,
          3549258,
          3558028,
          2895849,
          3521949,
          3571004,
          3527374,
          3545401,
          3545398,
          3545397,
          3545092,
          3545072,
          3545068,
          3527652,
          3527375,
          3527656,
          3540916,
          3527653,
          3522892,
          3522917,
          3530971,
          2895850,
          3521335,
          3527384,
          3527658,
          3527657,
          3527655,
          3527654,
          3527922,
          3527650,
          3527616,
          3523307,
          3521913,
          2785427,
          2788964,
          3522358,
          2921810,
          2895851,
          2900975,
          2801362,
          3519525,
          2871637,
          2876867,
          3518029
        ],
        "include_ui_filter": 1,
      };

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
