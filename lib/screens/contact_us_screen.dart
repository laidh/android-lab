import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:volunteer/widgets/email_send_widget.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactUsScreenState();
  }
}

class ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          "Зв`язатись з нами",
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
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _buildEmail(),
                        SizedBox(height: 18.0),
                        _buildPhoneNumber(),
                        SizedBox(height: 18.0),
                        _buildMessage(),
                        SizedBox(height: 18.0),
                        _buildButtons()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(children: <Widget>[
      Expanded(
        child: Align(
          alignment: Alignment.center,
          child: TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(6))),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return Color.fromARGB(55, 175, 83, 157);
                  })),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                  "Скасувати",
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                ),
              ),
              onPressed: () {
                log("Cancel was pressed");
                //TODO: going back to previous page on press
                //Navigator.pop(context);
              }),
        ),
      ),
      Expanded(
        child: Align(
          alignment: Alignment.center,
          child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(6.0))),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return Color.fromARGB(255, 0, 156, 162);
                })),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                "Надіслати",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Trying to send it')));
                _formKey.currentState?.save();
                if (_phoneController.text.isNotEmpty) {
                  Email.sendEmail(
                    toEmail: 'marko6462@gmail.com',
                    subject: 'Contact form',
                    body: _messageController.text +
                        "Телефон: " +
                        _phoneController.text,
                  );
                } else {
                  Email.sendEmail(
                    toEmail: 'marko6462@gmail.com',
                    subject: 'Contact form',
                    body: _messageController.text,
                  );
                }
              }
            },
          ),
        ),
      ),
    ]);
  }

  Widget _buildEmail() {
    //TODO:Gather email from firebase.
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(6)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(6)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(6)),
          labelText: 'Електронна пошта*',
          contentPadding: EdgeInsets.fromLTRB(14, 24, 10, 14),
          isDense: true,
          labelStyle: TextStyle(fontSize: 18, height: 2.5),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          fillColor: Color.fromARGB(255, 242, 245, 250),
          filled: true),
      textAlignVertical: TextAlignVertical.bottom,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Введіть email";
        }
        if (!RegExp(
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(value)) {
          return "Будь ласка, введіть правильний email";
        }
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      controller: _phoneController,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(6)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(6)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(6)),
          labelText: 'Телефон',
          contentPadding: EdgeInsets.fromLTRB(14, 24, 10, 14),
          isDense: true,
          labelStyle: TextStyle(fontSize: 18, height: 2.5),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          fillColor: Color.fromARGB(255, 242, 245, 250),
          filled: true),
      textAlignVertical: TextAlignVertical.bottom,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isNotEmpty) {
          if (!RegExp(r'^\+?3?8?(0\d{9})$').hasMatch(value.toString())) {
            return "Будь ласка, введіть правильний телефон";
          }
        }
        return null;
      },
    );
  }

  Widget _buildMessage() {
    return TextFormField(
      controller: _messageController,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(6)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(6)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(6)),
          labelText: 'Ваше повідомлення',
          contentPadding: EdgeInsets.fromLTRB(14, 24, 10, 14),
          labelStyle: TextStyle(fontSize: 18, height: 2.5),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          fillColor: Color.fromARGB(255, 242, 245, 250),
          filled: true),
      textAlignVertical: TextAlignVertical.bottom,
      keyboardType: TextInputType.multiline,
      maxLines: 15,
      maxLength: 500,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Введіть Повідомлення";
        }
        return null;
      },
    );
  }
}
