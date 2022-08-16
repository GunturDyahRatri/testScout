import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testscout/models/profile.dart';

class Prefs {
  Prefs._();

  static late SharedPreferences _prefs;

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future<void> logout({bool clear = false}) async {
    if (clear) {
      await _prefs.clear();
    } else {
      await _prefs.remove('token');
      await _prefs.remove('isStarted');
      await _prefs.remove('profile');
    }
  }

  // static bool get isStarted => _prefs.getBool('isStarted') ?? false;
  static bool get isStarted => kDebugMode;
  static void setStarted() => _prefs.setBool('isStarted', true);

  static bool get isLoggedIn => token?.isNotEmpty ?? false;
  static String? get token => _prefs.getString('token');
  static void setToken(String? token) => _prefs.setString('token', token ?? '');

  static Profile get profile =>
      Profile.fromJson(jsonDecode(_prefs.getString('profile') ?? '{}'));
  static void setProfile(Profile? profile) =>
      _prefs.setString('profile', jsonEncode(profile?.toJson() ?? {}));

  static String? get username => _prefs.getString('username');
  static void setUsername(String? v) => _prefs.setString('username', v ?? '');

  // static String get heatmapColor => _prefs.getString('heatmapColor') ?? '{}';
  // static void setHeatmapColor(String? v) =>
  //     _prefs.setString('heatmapColor', v ?? '');
}
