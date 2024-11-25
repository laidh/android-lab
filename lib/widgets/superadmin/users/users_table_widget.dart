import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/models/ui/user_filters.dart';
import 'package:volunteer/models/users/user.dart';
import 'package:volunteer/models/user_role.dart';
import 'package:volunteer/widgets/superadmin/users/users_filters_widget.dart';

class UsersTableWidget extends StatefulWidget {
  final List<User> users;

  UsersTableWidget(this.users);

  @override
  _UsersTableWidgetState createState() => _UsersTableWidgetState();
}

class _UsersTableWidgetState extends State<UsersTableWidget> {
  late UserFilters _filters;

  @override
  void initState() {
    super.initState();

    _filters = UserFilters();
  }

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
                "Користувачі",
                style: Theme.of(context).textTheme.headline5,
              ),
              Spacer(),
              Container(
                height: 40.0,
                child: FloatingActionButton.extended(
                    onPressed: () {
                      _showFilters(context).then((filters) => setState(() {
                            _filters = filters ?? UserFilters();
                          }));
                    },
                    label: Text('Фільтри'),
                    icon: Icon(Icons.filter_alt_outlined)),
              )
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          _buildUsersTable(context)
        ],
      ),
    );
  }

  Widget _buildUsersTable(BuildContext context) {
    List<User> users = widget.users.where((user) {
      if (_filters.userRole == -1) {
        return true;
      }

      return user.role.index == _filters.userRole;
    }).toList();

    if (users.isEmpty) {
      return Expanded(
          child: Center(
              child: Text('Немає користувачів',
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
        rows: List<DataRow>.generate(users.length, (index) {
          final user = users[index];

          return DataRow(cells: [
            DataCell(Text('${index + 1}')),
            DataCell(Text('${user.email}')),
            DataCell(Text('${user.firstName} ${user.lastName}')),
            DataCell(Text('${_roleFromIntUkrainian(user.role)}')),
            DataCell(Row(
              children: [
                if (user.role != UserRole.SUPER_ADMIN)
                  IconButton(
                      splashRadius: 24.0,
                      icon: Icon(
                        Icons.delete,
                        color: Colors.pink,
                        size: 20.0,
                      ),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.id)
                            .delete();
                      })
              ],
            ))
          ]);
        }));
  }

  Future<UserFilters?> _showFilters(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return UsersFiltersWidget(_filters);
        });
  }

  String _roleFromIntUkrainian(UserRole value) {
    switch (value) {
      case UserRole.VOLUNTEER:
        return 'Волонтер';
      case UserRole.ADMIN:
        return 'Адміністратор Молодіжного Центру';
      case UserRole.REGION_ADMIN:
        return 'Адміністратор Обласного Молодіжного Центру';
      case UserRole.SUPER_ADMIN:
        return 'Суперадміністратор';
      default:
        return 'Ти хто?';
    }
  }
}
