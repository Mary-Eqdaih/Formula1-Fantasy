import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageData {
  static const String favsKey = 'favoriteTeams';
  static const String _prefsKey = 'fantasy_team';
  static const String _localeKey = 'app_locale';




  // static const userEmailKey = 'user_email';
  // static const String userNameKey = 'userName';

  // // User Name
  // Future<void> saveEmail(String email) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(userEmailKey, email);
  // }
  //
  // Future<String?> getSavedEmail() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(userEmailKey);
  // }
  //
  // Future<void> saveUsername(String userName) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(userNameKey, userName);
  // }
  //
  // Future<String?> getSUsername() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(userNameKey);
  // }
  //
  // Future<void> clearEmail() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove(userEmailKey);
  // }
  // Future<void> clearUsername() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove(userNameKey);
  // }
  //////////////////////////////////////////////////////////////////////////////

  // Favorites

  // Save list of team IDs {list of strings}
  static Future<void> saveFavorites(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(favsKey, ids);
  }

  // Load list of team IDs {list of strings}
  static Future<List<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(favsKey) ?? [];
  }
  //////////////////////////////////////////////////////////////////////////////

  // Fantasy

  // Saves a list of driver IDs
  static Future<void> saveFantasyTeam(List<String> driverIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, jsonEncode(driverIds));
  }

  static Future<void> clearTeam() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
  }

  // Returns the saved list of driver IDs, or null if nothing was saved
  static Future<List<String>?> loadFantasyTeam() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null) return null;
    return List<String>.from(jsonDecode(raw));
  }


  ///////////////////////////////////////////////////////////////////////////////////

//Language
  static Future<void> saveLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, languageCode);
  }

  static Future<String> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_localeKey) ?? 'en';
  }
}
