import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:volunteer/models/users/user.dart';
import 'package:volunteer/providers/main_provider.dart';
import 'package:volunteer/screens/information_screen.dart';
import 'package:volunteer/screens/profile/profile_screen.dart';
import 'package:volunteer/screens/volunteerings_centers_list_screen.dart';
import 'package:volunteer/screens/volunteerings_list_screen.dart';

class HomeMobileScreen extends StatefulWidget {
  @override
  _HomeMobileScreenState createState() => _HomeMobileScreenState();
}

class _HomeMobileScreenState extends State<HomeMobileScreen> {
  final CollectionReference<User> usersCollection = FirebaseFirestore.instance
      .collection('users')
      .withConverter<User>(
          fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson());

  var _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              currentIndex: _selectedTab,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                        'assets/images/main_screen/volunteerings_tab.svg'),
                    activeIcon: SvgPicture.asset(
                        'assets/images/main_screen/volunteerings_tab_active.svg'),
                    label: 'Волонтерства'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                        'assets/images/main_screen/volunteerings_centers_tab.svg'),
                    activeIcon: SvgPicture.asset(
                        'assets/images/main_screen/volunteerings_centers_tab_active.svg'),
                    label: 'Молодіжні центри'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                        'assets/images/main_screen/information_tab.svg'),
                    activeIcon: SvgPicture.asset(
                        'assets/images/main_screen/information_tab_active.svg'),
                    label: 'Інформація'),
              ],
              onTap: (index) => setState(() => _selectedTab = index),
            ),
            body: SafeArea(child: _build(context))));
  }

  Widget _build(BuildContext context) {
    if (_selectedTab == 0) {
      return VolunteeringsListScreen();
    } else if (_selectedTab == 1) {
      return VolunteeringsCentersListScreen();
    } else {
      return InformationScreen();
    }
  }
}
