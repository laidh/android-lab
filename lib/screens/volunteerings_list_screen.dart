import 'package:flutter/material.dart';
import 'package:volunteer/screens/profile/profile_screen.dart';

class VolunteeringsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text(
            "Мої волонтерства",
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.grey[800],
                  size: 36,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
              ),
            ),
          ],
        ),
        body: Center(
          child: Text('В розробці'),
        ));
  }
}
