import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageData {
  static const String _favsKey = 'favoriteTeams';
  static const String _fantasyKey = 'fantasy_team';
  static const String _localeKey = 'app_locale';

  // Helper to generate user-specific keys
  static String _userKey(String key, String userId) => '${key}_$userId';

  // Favorites
  static Future<void> saveFavorites(String userId, List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_userKey(_favsKey, userId), ids);
  }

  static Future<List<String>> loadFavorites(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_userKey(_favsKey, userId)) ?? [];
  }

  // Fantasy Team
  static Future<void> saveFantasyTeam(String userId, List<String> driverIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey(_fantasyKey, userId), jsonEncode(driverIds));
  }

  static Future<void> clearTeam(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey(_fantasyKey, userId));
  }

  static Future<List<String>?> loadFantasyTeam(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_userKey(_fantasyKey, userId));
    if (raw == null) return null;
    return List<String>.from(jsonDecode(raw));
  }

  // Language
  static Future<void> saveLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, languageCode);
  }

  static Future<String> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_localeKey) ?? 'en';
  }
}
