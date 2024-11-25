import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/models/users/user.dart';
import 'package:volunteer/screens/profile/profile_screen.dart';
import 'package:volunteer/widgets/superadmin/users/users_search_delegate.dart';
import 'package:volunteer/widgets/superadmin/users/users_table_widget.dart';

class UsersListScreen extends StatelessWidget {
  final CollectionReference<User> usersCollection = FirebaseFirestore.instance
      .collection('users')
      .withConverter<User>(
          fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<User>>(
      stream: usersCollection.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }

        final users = snapshot.data!.docs.map((doc) => doc.data()).toList();

        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context, delegate: UsersSearchDelegate(users));
                  }),
              actions: [
                IconButton(
                    icon: Icon(Icons.account_circle),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()));
                    })
              ],
            ),
            body: UsersTableWidget(users));
      },
    );
  }
}
