import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:volunteer/screens/contact_us_screen.dart';
import 'package:volunteer/screens/browser_screen.dart';
import 'package:volunteer/screens/splash_screen.dart';
import 'package:volunteer/widgets/rate_app_init_widget.dart';


class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          "Налаштування",
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
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 22, bottom: 15, left: 14),
            child: Text(
              "Юридичні аспекти",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Column(
            children: [
              _buildMenuItemWidget(
                  'assets/images/settings_screen/policy.svg',
                  Icons.arrow_forward_ios_outlined,
                  "Політика конфеденційності",
                  () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BrowserScreen(
                                url:
                                    'https://www.google.com/search?q=privacy+policy',
                                title: 'Політика конфіденційності',
                              )))),
              _buildMenuItemWidget(
                  'assets/images/settings_screen/terms.svg',
                  Icons.arrow_forward_ios_outlined,
                  "Умови використання",
                  () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BrowserScreen(
                              url:
                                  'https://www.google.com/search?q=terms+and+conditions',
                              title: 'Умови використання')))),
              _buildMenuItemWidget(
                  'assets/images/settings_screen/file.svg',
                  Icons.arrow_forward_ios_outlined,
                  "Ліцензії",
                  () => log("Tapped")),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 22, bottom: 15, left: 14),
                child: Text(
                  "Зворотній зв'язок",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Column(
                children: [
                  _buildMenuItemWithSubtitleWidget(
                      'assets/images/settings_screen/mail.svg',
                      Icons.arrow_forward_ios_outlined,
                      "Зв'язатися з нами",
                      "Перехід до застосунку електронної пошти", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactUsScreen()));
                  }),
                  _buildMenuItemWithSubtitleWidget(
                      'assets/images/settings_screen/thumb_up.svg',
                      Icons.arrow_forward_ios_outlined,
                      "Оцінити додаток",
                      _getOpenInMarketText(),
                      () => log("Tapped")),
                  Container(
                    alignment: Alignment.topLeft,
                    margin:
                        const EdgeInsets.only(top: 22, bottom: 15, left: 14),
                    child: Text(
                      "Аккаунт",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      _buildMenuItemWithSubtitleWidget(
                          'assets/images/settings_screen/lock.svg',
                          Icons.arrow_forward_ios_outlined,
                          "Безпека",
                          "Налаштування паролю",
                          () => log("Tapped")),
                      _buildMenuItemWidget(
                          'assets/images/settings_screen/exit.svg',
                          Icons.arrow_forward_ios_outlined,
                          "Вийти",
                          () => _showExitConfirmationDialog(context)),
                      _buildMenuItemWidget(
                          'assets/images/settings_screen/bin.svg',
                          Icons.arrow_forward_ios_outlined,
                          "Видалити аккаунт",
                          () => log("Tapped")),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItemWidget(
      String svgpicture, IconData icon, String text, GestureTapCallback onTap) {
    return ListTile(
        leading: SvgPicture.asset(svgpicture),
        trailing: Icon(icon, size: 20, color: Colors.grey[800]),
        title: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey[700])),
        onTap: onTap);
  }

  Widget _buildMenuItemWithSubtitleWidget(String svgpicture, IconData icon,
      String text, String subtitle, GestureTapCallback onTap) {
    return ListTile(
        leading: SvgPicture.asset(svgpicture),
        trailing: Icon(icon, size: 20, color: Colors.grey[800]),
        title: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey[700])),
        subtitle: Text(subtitle),
        onTap: onTap);
  }

  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Вихід'),
            content: Text('Ви справді бажаєте вийти з додатку?'),
            actions: [
              TextButton(
                child: Text('Ні', style: TextStyle(color: Colors.blueGrey)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                  child: Text('Так'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then(
                          (_) => {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => SplashScreen()),
                                (route) => false)
                          },
                        );
                  })
            ],
          );
        });
  }

  String _getOpenInMarketText() {
    if (Platform.isAndroid) {
      RateAppInitWidget rate = new RateMyApp() as RateAppInitWidget;
      rate.builder;
      return "Перехід до Play Market";
    } else if (Platform.isIOS) {
      RateAppInitWidget rate = new RateMyApp() as RateAppInitWidget;
      rate.builder;
      return "Перехід до App Store";
    } else {
      return "";
    }
  }
}
