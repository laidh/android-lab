import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/models/tasks/task.dart';
import 'package:volunteer/screens/home/superadmin/tasks/create_task_screen.dart';
import 'package:volunteer/screens/profile/profile_screen.dart';
import 'package:volunteer/widgets/superadmin/tasks/tasks_search_delegate.dart';
import 'package:volunteer/widgets/superadmin/tasks/tasks_table_widget.dart';

class TasksScreen extends StatelessWidget {
  final CollectionReference<Task> pollsCollection = FirebaseFirestore.instance
      .collection('tasks')
      .withConverter<Task>(
          fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Task>>(
      stream: pollsCollection.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }

        final taskDocuments =
            snapshot.data!.docs.map((doc) => doc.data()).toList();

        return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              icon: Icon(Icons.add),
              label: Text('Створити'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateTaskScreen()));
              },
            ),
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: TasksSearchDelegate(taskDocuments));
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
            body: TasksTableWidget(taskDocuments));
      },
    );
  }
}
