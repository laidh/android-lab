import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volunteer/screens/profile/personal_information_screen.dart';
import 'package:volunteer/screens/settings/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text(
            "Мій профіль",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(children: [
          SizedBox(
            height: 42,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/images/default_avatar.jpg'),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Ім'я Прізвище",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text("волонтер у МЦ _________"),
            SizedBox(
              height: 42,
            ),
            Column(
              children: [
                ListTile(
                  leading: SvgPicture.asset(
                      'assets/images/profile_screen/controls_alt.svg'),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 32.0,
                  ),
                  title: Text(
                    "Налаштування",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("Зворотній зв'язок і керування паролем"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsScreen()));
                  },
                ),
                ListTile(
                  leading:
                      SvgPicture.asset('assets/images/profile_screen/cup.svg'),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 30.0,
                  ),
                  title: Text(
                    "Мої досягнення",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    log("Button Arrow My Achievements was pressed");
                  },
                ),
                ListTile(
                  leading:
                      SvgPicture.asset('assets/images/profile_screen/pole.svg'),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 30.0,
                  ),
                  title: Text(
                    "Мої опитування",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    log("Button Arrow My Polls was pressed");
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(
                      'assets/images/profile_screen/shield.svg'),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 30.0,
                  ),
                  title: Text(
                    "Особиста інформація",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("Редагування профілю"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PersonalInformationScreen()));
                    log("Button Arrow Personal information was pressed");
                  },
                )
              ],
            ),
          ]),
        ]));
  }
}
