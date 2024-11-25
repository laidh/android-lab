import 'package:flutter/material.dart';
import 'package:volunteer/models/tasks/task.dart';
import 'package:volunteer/models/users/user.dart';
import 'package:volunteer/widgets/superadmin/tasks/tasks_table_widget.dart';

class TasksSearchDelegate extends SearchDelegate<User?> {
  final List<Task> tasks;

  TasksSearchDelegate(this.tasks);

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
        ? tasks
        : tasks.where((task) {
            var result = false;

            if (task.title.contains(query)) {
              result = true;
            }

            return result;
          }).toList();

    return TasksTableWidget(suggestions);
  }
}
