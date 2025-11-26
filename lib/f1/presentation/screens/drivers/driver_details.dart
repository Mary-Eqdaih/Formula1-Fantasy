// import 'package:flutter/material.dart';
// import 'package:formula1_fantasy/f1/data/models/driver_model.dart';
// import 'package:formula1_fantasy/f1/presentation/widgets/driver_widget.dart';
//
// class DriverDetails extends StatelessWidget {
//   const DriverDetails({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final model = ModalRoute.of(context)!.settings.arguments as DriverModel;
//     const darkBg = Color(0xFF0F0F10);
//
//     return Scaffold(
//       backgroundColor: darkBg,
//       appBar: AppBar(
//         backgroundColor: darkBg,
//         title: const Text(
//           "Driver Details",
//           style: TextStyle(color: Colors.white),
//         ),
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: DriverWidget(model: model),
//       ),
//     );
//
//   }
// }
