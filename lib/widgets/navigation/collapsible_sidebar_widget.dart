import 'package:flutter/material.dart';
import 'package:volunteer/models/ui/navigation_item.dart';
import 'package:volunteer/widgets/navigation/collapsible_list_tile_widget.dart';

class CollapsibleSideBarWidget extends StatefulWidget {
  final Function(NavigationItemOption option)? onNavigationItemSelected;

  CollapsibleSideBarWidget({this.onNavigationItemSelected});

  @override
  _CollapsibleSideBarWidgetState createState() =>
      _CollapsibleSideBarWidgetState();
}

class _CollapsibleSideBarWidgetState extends State<CollapsibleSideBarWidget>
    with SingleTickerProviderStateMixin {
  final _expandedWidth = 224.0;
  final _collapsedWidth = 56.0;
  bool _isCollapsed = false;
  int _selectedIndex = 0;

  late AnimationController _animationController;
  late Animation<double> _widthAnimation;

  List<NavigationItem> navigationItems = [
    NavigationItem(NavigationItemOption.DASHBOARD, 'Головна', Icons.dashboard),
    NavigationItem(NavigationItemOption.USERS, 'Користувачі',
        Icons.account_circle_rounded),
    NavigationItem(NavigationItemOption.POLLS, 'Опитування', Icons.poll),
    NavigationItem(
        NavigationItemOption.TASKS, 'Завдання', Icons.run_circle_rounded),
    NavigationItem(NavigationItemOption.INFORMATION, 'Інформація', Icons.info),
    NavigationItem(
        NavigationItemOption.SETTINGS, 'Налаштування', Icons.settings),
  ];

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _widthAnimation = Tween<double>(begin: _expandedWidth, end: _collapsedWidth)
        .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    final onNavigationItemSelected = widget.onNavigationItemSelected;

    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, widget) {
          return Container(
            color: Colors.pink,
            width: _widthAnimation.value,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: navigationItems.length,
                      itemBuilder: (context, index) {
                        return CollapsibleListTileWidget(
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;

                                onNavigationItemSelected?.call(
                                    navigationItems[index]
                                        .navigationItemOption);
                              });
                            },
                            isSelected: _selectedIndex == index,
                            leading: navigationItems[index].icon,
                            title: navigationItems[index].title);
                      }),
                ),
                Divider(
                  height: 1.0,
                  color: Colors.white,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isCollapsed = !_isCollapsed;
                      _isCollapsed
                          ? _animationController.reverse()
                          : _animationController.forward();
                    });
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0, right: 12.0, top: 8.0),
                      child: AnimatedIcon(
                        icon: AnimatedIcons.arrow_menu,
                        progress: _animationController,
                        color: Colors.white,
                        size: 32.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
