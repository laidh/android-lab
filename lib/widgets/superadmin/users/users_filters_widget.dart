import 'package:flutter/material.dart';
import 'package:volunteer/models/ui/user_filters.dart';
import 'package:volunteer/models/user_role.dart';

class UsersFiltersWidget extends StatefulWidget {
  final UserFilters previousFilters;

  UsersFiltersWidget(this.previousFilters);

  @override
  _UsersFiltersWidgetState createState() => _UsersFiltersWidgetState();
}

class _UsersFiltersWidgetState extends State<UsersFiltersWidget> {
  late UserFilters _filters;

  @override
  void initState() {
    super.initState();

    _filters = widget.previousFilters;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Фільтри'),
      content: IntrinsicHeight(
        child: Column(
          children: [
            DropdownButton<int>(
                hint: Text('Роль'),
                value: _filters.userRole == -1 ? null : _filters.userRole,
                isExpanded: true,
                items: UserRole.values
                    .where((e) => e != UserRole.SUPER_ADMIN)
                    .map((e) => DropdownMenuItem(
                        value: e.index,
                        child: FittedBox(
                          child: Text(
                            e.valueUkrainian(),
                          ),
                        )))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _filters.userRole = value ?? UserRole.VOLUNTEER.index;
                  });
                }),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Відмінити', style: TextStyle(color: Colors.blueGrey)),
          onPressed: () {
            Navigator.pop(context, UserFilters());
          },
        ),
        TextButton(
          child: Text('Застосувати'),
          onPressed: () {
            Navigator.pop(context, _filters);
          },
        )
      ],
    );
  }
}
