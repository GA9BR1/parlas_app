import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String baseUrl = "http://10.0.2.2:3000";
  User user = User();

  AuthProvider() {
    populateUser();
  }

  Future<void> authenticate(
      {required String email,
      required String password,
      required BuildContext context}) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    var url = Uri.parse("$baseUrl/auth/sign_in");
    await http.post(url, body: {
      "email": email,
      "password": password,
    }).then((response) async {
      if (response.statusCode == 200) {
        user.uid = response.headers['uid'];
        user.client = response.headers['client'];
        user.accessToken = response.headers['access-token'];
        await persistUser();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid email or password")));
      }
    }).onError((_, __) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("An unkown error has ocourred. Try again later")));
    }).whenComplete(() => Navigator.pop(context));

    notifyListeners();
  }

  Future<void> persistUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', user.uid!);
    prefs.setString('client', user.client!);
    prefs.setString('accessToken', user.accessToken!);
  }

  Future<void> populateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user.uid = prefs.getString('uid');
    user.client = prefs.getString('client');
    user.accessToken = prefs.getString('accessToken');
    notifyListeners();
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('uid');
    prefs.remove('client');
    prefs.remove('accessToken');
    user.uid = null;
    user.client = null;
    user.accessToken = null;
    notifyListeners();
  }

  get isLoggedIn => user.uid != null;
}

class User {
  String? uid;
  String? client;
  String? accessToken;
}
