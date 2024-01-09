import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  User user = User();
  late SharedPreferences prefs;

  AuthProvider(this.prefs);

  Future<void> populateUser() async {
    user.uid = prefs.getString('uid');
    user.client = prefs.getString('client');
    user.accessToken = prefs.getString('accessToken');
    notifyListeners();
  }

  get isLoggedIn => user.uid != null;
}

class User {
  String? uid;
  String? client;
  String? accessToken;
}
