import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/race_info_model.dart';
import '../models/race_details_model.dart';

class F1Api {
  static const _base = 'https://api.jolpi.ca/ergast/f1';

  static Future<RaceInfoModel> fetchLatestRace() async {
    final result = await http.get(
      Uri.parse('$_base/current/last/results.json'),
    );
    if (result.statusCode != 200) throw Exception('HTTP ${result.statusCode}');
    final data = json.decode(result.body);
    final race = data['MRData']['RaceTable']['Races'][0];
    final results = race['Results'][0];
    final raceName = race['raceName'];
    final circuit = race['Circuit']['circuitName'];
    final country = race['Circuit']['Location']['country'];
    final locality = race['Circuit']['Location']['locality'];
    final date = race['date'];
    final driver = results['Driver'];
    final constructor = results['Constructor'];
    final winner = '${driver['givenName']} ${driver['familyName']}';
    final team = constructor['name'];

    return RaceInfoModel(
      title: raceName,
      circuit: circuit,
      date: date,
      location: '$locality • $country',
      winner: winner,
      team: team,
    );
  }



  static Future<RaceInfoModel> fetchNextRace() async {
    final result = await http.get(Uri.parse('$_base/current/next.json'));
    if (result.statusCode != 200) throw Exception('HTTP ${result.statusCode}');
    final data = json.decode(result.body);
    final race = data['MRData']['RaceTable']['Races'][0];

    final raceName = race['raceName'];
    final circuit = race['Circuit']['circuitName'];
    final country = race['Circuit']['Location']['country'];
    final locality = race['Circuit']['Location']['locality'];
    final date = race['date'];

    return RaceInfoModel(
      title: raceName,
      circuit: circuit,
      date: date,
      location: '$locality • $country',
    );
  }


  static Future<RaceDetails> fetchLatestRaceDetails() async {
    final result = await http.get(
      Uri.parse('$_base/current/last/results.json'),
    );
    if (result.statusCode != 200) throw Exception('HTTP ${result.statusCode}');
    log(result.body);

    final data = json.decode(result.body);
    final raceJson = data['MRData']['RaceTable']['Races'][0];

    return RaceDetails.fromJson(raceJson);
  }

}
