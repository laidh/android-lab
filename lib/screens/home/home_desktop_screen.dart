import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volunteer/models/users/user.dart';
import 'package:volunteer/models/user_role.dart';
import 'package:volunteer/providers/main_provider.dart';
import 'package:volunteer/screens/home/superadmin/home_desktop_screen.dart'
    as superadmin;

class HomeDesktopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer<MainProvider>(
      builder: (context, model, child) {
        return StreamBuilder<DocumentSnapshot<User>>(
          stream: model.userReference?.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container();
            }

            var currentUser = snapshot.data?.data();
            if (currentUser?.role == UserRole.SUPER_ADMIN) {
              return superadmin.HomeDesktopScreen();
            }

            return Container();
          },
        );
      },
    ));
  }
}
