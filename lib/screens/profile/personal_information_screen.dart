import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:volunteer/widgets/personal_information/about_info_widget.dart';
import 'package:volunteer/widgets/personal_information/contact_info_widget.dart';
import 'package:volunteer/widgets/personal_information/general_info_widget.dart';
import 'package:volunteer/widgets/personal_information/socials_info_widget.dart';

class PersonalInformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text(
            "Особиста інформація",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GeneralInfoWidget(),
                    SizedBox(
                      height: 15,
                    ),
                    ContactInfoWidget(),
                    SizedBox(
                      height: 15,
                    ),
                    SocialsInfoWidget(),
                    SizedBox(
                      height: 15,
                    ),
                    AboutInfoWidget(),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                                minimumSize: Size(170, 45),
                                backgroundColor: Colors.pinkAccent[700]),
                            onPressed: () {
                              log("Button Cancel was pressed");
                            },
                            child: Text(
                              'Скасувати',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            )),
                        TextButton(
                            style: TextButton.styleFrom(
                                minimumSize: Size(170, 45),
                                backgroundColor: Colors.teal),
                            onPressed: () {
                              log("Button Save Changes was pressed");
                            },
                            child: Text(
                              'Зберегти зміни',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            )),
                      ],
                    )
                  ],
                ))));
  }
}
