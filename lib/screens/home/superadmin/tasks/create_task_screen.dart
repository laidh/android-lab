import 'package:flutter/material.dart';

class CreateTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Створити'))
        ],
      ),
    );
  }
}
