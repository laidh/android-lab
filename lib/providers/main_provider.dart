import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:volunteer/models/users/user.dart';

class MainProvider extends ChangeNotifier {
  DocumentReference<User>? _userReference;

  DocumentReference<User>? get userReference => _userReference;

  set userReference(DocumentReference<User>? value) {
    _userReference = value;
    notifyListeners();
  }
}
