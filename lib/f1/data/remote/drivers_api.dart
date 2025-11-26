import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:formula1_fantasy/f1/data/models/driver_model.dart';

// Gets Drivers By ConstructorID
class DriversApi {
  static const _base = 'https://api.jolpi.ca/ergast/f1/current/constructors';

  Future<List<DriverModel>> fetchDrivers(String constructorId) async {
    final url = '$_base/$constructorId/drivers.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to load drivers (${response.statusCode})');
    }

    final data = jsonDecode(response.body);
    final List driversJson =
    data['MRData']['DriverTable']['Drivers']; // list of maps each map is a driver

    final drivers =
    driversJson.map((map) => DriverModel.fromJson(map)).toList();

    return drivers;
  }
}
