import 'dart:developer';

import 'package:flutter/material.dart';

class ContactInfoWidget extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Контактна інформація",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(color: Colors.blueGrey[50]),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(), labelText: "Пошта"),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(), labelText: "Телефон"),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey[850],
                          ),
                          onPressed: () {
                            log("button Edit Location was pressed");
                          },
                        ),
                        border: InputBorder.none,
                        labelText: "Локація"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
