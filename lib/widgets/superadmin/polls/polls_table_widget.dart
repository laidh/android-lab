import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:volunteer/models/polls/poll.dart';
import 'package:volunteer/screens/home/superadmin/polls/poll_info_screen.dart';

class PollsTableWidget extends StatefulWidget {
  final List<Poll> polls;

  PollsTableWidget(this.polls);

  @override
  _PollsTableWidgetState createState() => _PollsTableWidgetState();
}

class _PollsTableWidgetState extends State<PollsTableWidget> {
  final _avatarPlaceholderPath =
      kIsWeb ? 'avatar_placeholder.png' : 'assets/avatar_placeholder.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                "Опитування",
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          _buildPollsTable(context)
        ],
      ),
    );
  }

  Widget _buildPollsTable(BuildContext context) {
    List<Poll> polls = widget.polls;

    if (polls.isEmpty) {
      return Expanded(
          child: Center(
              child: Text('Немає опитувань',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 16.0))));
    }

    return DataTable(
        showCheckboxColumn: false,
        columns: <DataColumn>[
          DataColumn(
              label: Text(
            '#',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: Text(
            'Найменування',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: Text(
            'Термін',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: Text(
            'Респонденти',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: Text(
            'Дії',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ],
        rows: List<DataRow>.generate(polls.length, (index) {
          final poll = polls[index];
          final startDate =
              DateFormat.yMMMMd('uk_UA').add_Hm().format(poll.startDate!);
          final endDate =
              DateFormat.yMMMMd('uk_UA').add_Hm().format(poll.endDate!);
          final dates = "$startDate - $endDate";

          return DataRow(
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text('${poll.title}')),
                DataCell(Text('$dates')),
                DataCell(Row(
                  children: [
                    ...poll.users!.map((user) {
                      return StreamBuilder<DocumentSnapshot>(
                          stream: (user as DocumentReference).snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Container();
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            return Tooltip(
                              message: snapshot.data?.get('name'),
                              child: CircleAvatar(
                                radius: 16.0,
                                backgroundImage:
                                    AssetImage(_avatarPlaceholderPath),
                                foregroundImage:
                                    // TODO: Download real user avatar when implemented
                                    AssetImage(_avatarPlaceholderPath),
                              ),
                            );
                          });
                    })
                  ],
                )),
                DataCell(Row(
                  children: [
                    IconButton(
                        splashRadius: 20.0,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.pink,
                          size: 20.0,
                        ),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('polls')
                              .doc(poll.id)
                              .delete();
                        }),
                  ],
                ))
              ],
              onSelectChanged: (_) {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => PollInfoScreen(),
                    transitionDuration: Duration(milliseconds: 0)));
              });
        }));
  }
}
