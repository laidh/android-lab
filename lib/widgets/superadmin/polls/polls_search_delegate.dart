import 'package:flutter/material.dart';
import 'package:volunteer/models/polls/poll.dart';
import 'package:volunteer/models/users/user.dart';
import 'package:volunteer/widgets/superadmin/polls/polls_table_widget.dart';

class PollsSearchDelegate extends SearchDelegate<User?> {
  final List<Poll> polls;

  PollsSearchDelegate(this.polls);

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
        ? polls
        : polls.where((poll) {
            var result = false;

            if (poll.title!.contains(query)) {
              result = true;
            }

            return result;
          }).toList();

    return PollsTableWidget(suggestions);
  }
}
