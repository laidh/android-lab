import 'package:flutter/material.dart';
import 'package:volunteer/screens/profile/profile_screen.dart';

class InformationScreen extends StatelessWidget {
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
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(children: [
              Text(
                "Інформація",
                style: Theme.of(context).textTheme.headline5,
              ),
            ])
          ]),
        ));
  }
}
