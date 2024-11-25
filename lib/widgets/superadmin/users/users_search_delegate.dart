import 'package:flutter/material.dart';
import 'package:volunteer/models/users/user.dart';
import 'package:volunteer/widgets/superadmin/users/users_table_widget.dart';

class UsersSearchDelegate extends SearchDelegate<User?> {
  final List<User> users;

  UsersSearchDelegate(this.users);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
            close(context, null);
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? users
        : users.where((user) {
            var result = false;

            if (user.firstName.contains(query)) {
              result = true;
            }

            if (user.lastName.contains(query)) {
              result = true;
            }

            if (user.email.contains(query)) {
              result = true;
            }

            return result;
          }).toList();

    return UsersTableWidget(suggestions);
  }
}
