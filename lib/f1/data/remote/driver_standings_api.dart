import 'dart:convert';
import 'package:formula1_fantasy/f1/data/models/driver_standings_model.dart';
import 'package:http/http.dart' as http;

class DriverStandingsApi {
  static const _url =
      'https://api.jolpi.ca/ergast/f1/current/driverStandings.json';

  static Future<List<DriverStandingModel>> fetchSeasonStandings() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode != 200) {
      throw Exception('Failed to load driver standings (${response.statusCode})');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    final standingsLists =
        (data['MRData']?['StandingsTable']?['StandingsLists'] as List?) ?? [];

    // ✅ If empty, return empty standings (NOT error)
    if (standingsLists.isEmpty) return [];

    final driverStandings =
        (standingsLists.first?['DriverStandings'] as List?) ?? [];

    return driverStandings
        .map((e) => DriverStandingModel.fromJson(e))
        .toList();
  }
}
