import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String baseUrl = "http://192.168.15.8:3000";
  User user = User();

  Future<AuthProvider> build() async {
    await populateUser();
    return this;
  }

  Future<void> authenticate({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse("$baseUrl/auth/sign_in");
    try {
      var response = await http.post(url, body: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        user.uid = response.headers['uid'];
        user.client = response.headers['client'];
        user.accessToken = response.headers['access-token'];
        await persistUser();
      } else if (response.statusCode == 401) {
        return Future.error('Your email or password are incorrect');
      } else {
        return Future.error('An unkown error has ocourred. Try again later');
      }
    } catch (e) {
      return Future.error('An unkown error has ocourred. Try again later');
    } finally {
      notifyListeners();
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    var url = Uri.parse("$baseUrl/auth");
    try {
      var response = await http.post(url, body: {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": password,
      });
      print(response.body);
      if (response.statusCode == 200) {
        user.uid = response.headers['uid'];
        user.client = response.headers['client'];
        user.accessToken = response.headers['access-token'];
        await persistUser();
      } else if (response.statusCode == 422) {
        return Future.error('You forgot to fill some fields. Fill them all');
      } else {
        return Future.error('An unkown error has ocourred. Try again later');
      }
    } catch (e) {
      return Future.error('An unkown error has ocourred. Try again later');
    }
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
    if (user.uid == null || user.client == null || user.accessToken == null) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse("$baseUrl/auth/sign_out");

    await http.delete(url, headers: {
      "uid": user.uid!,
      "client": user.client!,
      "access-token": user.accessToken!,
    });

    prefs.remove('uid');
    prefs.remove('client');
    prefs.remove('accessToken');
    user.uid = null;
    user.client = null;
    user.accessToken = null;
    notifyListeners();
  }

  Future<bool> isLoggedIn() async {
    var url = Uri.parse("$baseUrl/auth/validate_token");
    try {
      var response = await http.get(url, headers: {
        "uid": user.uid!,
        "client": user.client!,
        "access-token": user.accessToken!,
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

class User {
  String? uid;
  String? client;
  String? accessToken;
}
