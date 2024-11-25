import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/models/polls/poll.dart';
import 'package:volunteer/screens/home/superadmin/polls/create_poll_screen.dart';
import 'package:volunteer/screens/profile/profile_screen.dart';
import 'package:volunteer/widgets/superadmin/polls/polls_search_delegate.dart';
import 'package:volunteer/widgets/superadmin/polls/polls_table_widget.dart';

class PollsScreen extends StatelessWidget {
  final CollectionReference<Poll> pollsCollection = FirebaseFirestore.instance
      .collection('polls')
      .withConverter<Poll>(
          fromFirestore: (snapshot, _) => Poll.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Poll>>(
      stream: pollsCollection.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }

        final polls = snapshot.data!.docs.map((doc) => doc.data()).toList();

        return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              icon: Icon(Icons.add),
              label: Text('Створити'),
              onPressed: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => CreatePollScreen(),
                    transitionDuration: Duration(milliseconds: 0)));
              },
            ),
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context, delegate: PollsSearchDelegate(polls));
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
            body: PollsTableWidget(polls));
      },
    );
  }
}
