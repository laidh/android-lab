import 'dart:developer';

import 'package:flutter/material.dart';

class GeneralInfoWidget extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Загальне",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      SizedBox(height: 15),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/images/default_avatar.jpg'),
            ),
          ),
          Container(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Фото профілю",
                style: TextStyle(color: Colors.grey[400]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          minimumSize: Size(100, 40),
                          backgroundColor: Colors.teal[100]),
                      onPressed: () {
                        log("Button Change Profile Avatar was pressed");
                      },
                      child: Text(
                        'Замінити',
                        style: TextStyle(
                            color: Colors.teal[600],
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400),
                      )),
                  Container(width: 10),
                  TextButton(
                      style: TextButton.styleFrom(
                          minimumSize: Size(100, 40),
                          backgroundColor: Colors.pink[100]),
                      onPressed: () {
                        log("Button Delete Profile Avatar was pressed");
                      },
                      child: Text(
                        'Видалити',
                        style: TextStyle(color: Colors.pink[900], fontSize: 16),
                      )),
                ],
              )
            ],
          )
        ],
      ),
      SizedBox(
        height: 15,
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 50,
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.blueGrey[50],
                labelText: "Ім'я"),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 50,
          child: TextField(
            controller: surnameController,
            decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.blueGrey[50],
                labelText: "Прізвище"),
          ),
        ),
      ),
    ]);
  }
}
