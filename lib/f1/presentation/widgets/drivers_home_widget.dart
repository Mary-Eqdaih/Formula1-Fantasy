// import 'package:flutter/material.dart';
// import 'package:formula1_fantasy/f1/data/models/driver_model.dart';
// import 'package:formula1_fantasy/routes/routes.dart';
//
// class DriversWidgetHome extends StatelessWidget {
//   const DriversWidgetHome({super.key, required this.model});
//   final DriverModel model;
//   @override
//   Widget build(BuildContext context) {
//     const cardColor = Color(0xFF18191A);
//     const f1Red = Color(0xFFE10600);
//
//     return InkWell(
//       onTap: () {
//         Navigator.pushNamed(context, Routes.DriverDetails,arguments: model);
//       },
//       borderRadius: BorderRadius.circular(14),
//       child: Container(
//         decoration: BoxDecoration(
//           color: cardColor,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: f1Red.withOpacity(0.25), width: 1),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         child: Row(
//           children: [
//             Container(
//               width: 60,
//               height: 60,
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Image.asset(model.image, fit: BoxFit.contain),
//             ),
//             const SizedBox(width: 25),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     model.name,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'TitilliumWeb',
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     model.team,
//                     style: const TextStyle(
//                       color: Colors.white70,
//                       fontFamily: 'TitilliumWeb',
//                       fontSize: 13,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Text("${model.points}",style: TextStyle(color: Colors.white),),
//           ],
//         ),
//       ),
//     );
//   }
// }
