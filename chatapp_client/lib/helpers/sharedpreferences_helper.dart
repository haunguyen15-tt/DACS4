import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesHelper {
  static Future persistOnLogin(user, token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
    await prefs.setString('token', token);
  }

  static Future setAgoraToken(agoraToken, channelName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('channelName', channelName);
    await prefs.setString('agoraToken', agoraToken);
  }

  static getAgoraToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('agoraToken');
  }

  static getAgoraChannelName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('channelName');
  }

  static Future getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      return json.decode(prefs.getString('user'));
    } else {
      return null;
    }
  }

  static Future getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      return json.decode(prefs.getString('token'));
    } else {
      return null;
    }
  }

  static Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
  }
}
