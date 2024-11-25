import 'package:flutter/material.dart';

/// Represents navigation item for menu
class NavigationItem {
  NavigationItemOption navigationItemOption;
  String title;
  IconData icon;

  NavigationItem(this.navigationItemOption, this.title, this.icon);
}

enum NavigationItemOption {
  DASHBOARD,
  USERS,
  POLLS,
  TASKS,
  INFORMATION,
  SETTINGS
}
