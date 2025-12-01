// import 'package:flutter/cupertino.dart';
// import 'package:formula1_fantasy/f1/data/models/driver_model.dart';
// import 'package:formula1_fantasy/f1/data/models/driver_standings_model.dart';
// import 'package:formula1_fantasy/f1/data/models/teams_model.dart';
// import 'package:formula1_fantasy/f1/data/remote/driver_standings_api.dart';
// import 'package:formula1_fantasy/f1/data/remote/drivers_api.dart';
// import 'package:formula1_fantasy/f1/data/remote/teams_api.dart';
//
// import '../../data/local/local_storage.dart' show LocalStorageData;
//
// class F1Provider extends ChangeNotifier {
//   List<TeamsModel> teams = [];
//   List<TeamsModel> favs = [];
//   Map<String, List<DriverModel>> driversByTeam = {};
//   List<DriverModel> drivers = [];
//   List<DriverStandingModel> driversStanding = [];
//
//   void init() async {
//     await fetchTeams();
//     await loadFavorites();
//     // await fetchAllDrivers();
//     await fetchDriversStanding();
//   }
//
//   // fetch teams and drivers
//   fetchTeams() async {
//     var fetchedTeams = await TeamsApi().fetchTeams();
//     teams = fetchedTeams;
//     notifyListeners();
//   }
//
//   // // Fetch all drivers for all teams
//   // Future<void> fetchAllDrivers() async {
//   //   for (var team in teams) {
//   //     await fetchDriversFor(team.constructorId);
//   //   }
//   //
//   //   drivers.sort(
//   //     (a, b) => b.points.compareTo(a.points),
//   //   ); // Sort once after fetching
//   //   print(drivers);
//   //   notifyListeners();
//   // }
//
//
//
//   // fetch Drivers Standing
//   fetchDriversStanding() async {
//     var fetchedStandings = await DriverStandingsApi.fetchSeasonStandings();
//     driversStanding = fetchedStandings;
//     notifyListeners();
//   }
//
//   List<DriverModel> driversFor(String constructorId) {
//     return driversByTeam[constructorId] ?? const [];
//   }
//
//   // returns all drivers for a given team (by ID).
//   Future<void> fetchDriversFor(String constructorId) async {
//     // avoid refetching if already cached
//     if (driversByTeam.containsKey(constructorId)) return;
//     final fetched = await DriversApi().fetchDrivers(constructorId);
//     driversByTeam[constructorId] = fetched;
//
//     /**
//      * After fetching the drivers from the API, the list of DriverModel objects is stored in
//      * the driversByTeam map under the key constructorId. This ensures that next time you request
//      * drivers for this team,they’ll be fetched from the cache, not the API.
//      */
//     notifyListeners();
//   }
//
//   // add and remove from favs
//   addToFavorites(TeamsModel team) {
//     favs.add(team);
//     saveFavoritesToStorage();
//     notifyListeners();
//   }
//
//   removeFromFavorites(TeamsModel team) {
//     favs.remove(team);
//     saveFavoritesToStorage();
//     notifyListeners();
//   }
//
//   // Save favorites IDs to SharedPreferences
//   Future<void> saveFavoritesToStorage() async {
//     final ids = favs.map((team) => team.constructorId).toList();
//     await LocalStorageData.saveFavorites(ids);
//   }
//
//   // Load favorites IDs and rebuild list
//   Future<void> loadFavorites() async {
//     final savedIds = await LocalStorageData.loadFavorites();
//     favs = teams
//         .where((team) => savedIds.contains(team.constructorId))
//         .toList();
//     notifyListeners();
//   }
// }
