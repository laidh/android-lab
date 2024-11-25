import 'package:flutter/material.dart';
import 'package:volunteer/models/ui/navigation_item.dart';
import 'package:volunteer/screens/home/superadmin/information_screen.dart';
import 'package:volunteer/screens/home/superadmin/polls/polls_screen.dart';
import 'package:volunteer/screens/home/superadmin/settings_screen.dart';
import 'package:volunteer/screens/home/superadmin/tasks/tasks_screen.dart';
import 'package:volunteer/widgets/navigation/collapsible_sidebar_widget.dart';
import 'package:volunteer/screens/home/superadmin/dashboard_screen.dart';
import 'package:volunteer/screens/home/superadmin/users_list_screen.dart';

class HomeDesktopScreen extends StatefulWidget {
  @override
  _HomeDesktopScreenState createState() => _HomeDesktopScreenState();
}

class _HomeDesktopScreenState extends State<HomeDesktopScreen> {
  NavigationItemOption _navigationItemOption = NavigationItemOption.DASHBOARD;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: CollapsibleSideBarWidget(onNavigationItemSelected: (option) {
              setState(() {
                _navigationItemOption = option;
              });
            }),
          ),
          Expanded(
            child: Navigator(
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  builder: (_) => _buildMainScreen(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainScreen() {
    switch (_navigationItemOption) {
      case NavigationItemOption.DASHBOARD:
        return DashboardScreen();
      case NavigationItemOption.USERS:
        return UsersListScreen();
      case NavigationItemOption.POLLS:
        return PollsScreen();
      case NavigationItemOption.TASKS:
        return TasksScreen();
      case NavigationItemOption.INFORMATION:
        return InformationScreen();
      case NavigationItemOption.SETTINGS:
        return SettingsScreen();
    }
  }
}
