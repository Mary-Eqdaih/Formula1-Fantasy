// import 'package:flutter/material.dart';
// import 'package:formula1_fantasy/f1/data/models/driver_model.dart';
// import 'package:formula1_fantasy/f1/data/remote/all_drivers_api.dart';
// import 'package:formula1_fantasy/f1/presentation/widgets/drivers_home_widget.dart';
//
// class DriversScreen extends StatefulWidget {
//   const DriversScreen({super.key});
//
//   @override
//   State<DriversScreen> createState() => _DriversScreenState();
// }
//
// class _DriversScreenState extends State<DriversScreen> {
//   late Future<List<DriverModel>> _futureDrivers;
//
//   @override
//   void initState() {
//     super.initState();
//     _futureDrivers = AllDriversApi.fetchAllDrivers();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const darkBg = Color(0xFF0F0F10);
//
//     return Scaffold(
//       backgroundColor: darkBg,
//
//       body: FutureBuilder<List<DriverModel>>(
//         future: _futureDrivers,
//         builder: (context, snapshot) {
//           // 🔄 Loading
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           // ❌ Error
//           if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 'Failed to load drivers',
//                 style: const TextStyle(color: Colors.white),
//               ),
//             );
//           }
//
//           final drivers = snapshot.data ?? [];
//
//           // 😶 Empty
//           if (drivers.isEmpty) {
//             return const Center(
//               child: Text(
//                 'No drivers found.',
//                 style: TextStyle(color: Colors.white),
//               ),
//             );
//           }
//
//           // ✅ List of drivers
//           return ListView.separated(
//             itemCount: drivers.length,
//             separatorBuilder: (_, __) => const SizedBox(height: 10),
//             itemBuilder: (context, index) {
//               final driver = drivers[index];
//               return DriversWidgetHome(model: driver);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
