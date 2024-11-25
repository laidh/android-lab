import 'package:flutter/material.dart';
import 'package:volunteer/screens/profile/profile_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              })
        ],
      ),
      body: Column(
        children: <Widget>[
          Image.asset('assets/images/logo.png'),
        ],
      ),
    );
  }
}
