import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/models/tasks/task.dart';

class TasksTableWidget extends StatefulWidget {
  final List<Task> tasks;

  TasksTableWidget(this.tasks);

  @override
  _TasksTableWidgetState createState() => _TasksTableWidgetState();
}

class _TasksTableWidgetState extends State<TasksTableWidget> {
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
                "Завдання",
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
    List<Task> tasks = widget.tasks;

    if (tasks.isEmpty) {
      return Expanded(
          child: Center(
              child: Text('Немає завдань',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 16.0))));
    }

    return DataTable(
        columns: <DataColumn>[
          DataColumn(
              label: Text(
            '#',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: Text(
            'Електронна скринька',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: Text(
            "Ім'я",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: Text(
            'Роль',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataColumn(
              label: Text(
            'Дії',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ],
        rows: List<DataRow>.generate(tasks.length, (index) {
          final task = tasks[index];

          return DataRow(cells: [
            DataCell(Text('${index + 1}')),
            DataCell(Text('${task.title}')),
          ]);
        }));
  }
}
