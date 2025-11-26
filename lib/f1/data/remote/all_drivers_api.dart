// import 'dart:convert';
//
// import 'package:formula1_fantasy/f1/data/models/driver_model.dart';
// import 'package:http/http.dart' as http;
//
// class AllDriversApi {
//   static const _base = 'https://api.jolpi.ca/ergast/f1/current/drivers.json';
//
//   static Future<List<DriverModel>> fetchAllDrivers() async {
//     final response = await http.get(Uri.parse(_base));
//
//     if (response.statusCode != 200) {
//       throw Exception("Failed to load drivers");
//     }
//
//     final data = jsonDecode(response.body);
//     final List driversJson = data['MRData']['DriverTable']['Drivers'];
//
//     return driversJson
//         .map((driver) => DriverModel.fromJson(driver))
//         .toList();
//   }
// }
