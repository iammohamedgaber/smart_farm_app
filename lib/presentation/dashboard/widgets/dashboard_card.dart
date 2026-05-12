// import 'package:flutter/material.dart';

// const Color primaryColor = Color(0xFF4CAF50);
// CardDashboard(BuildContext context, String title, IconData icon) {
//   return Card(
//     elevation: 3,

//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

//     child: InkWell(
//       borderRadius: BorderRadius.circular(16),

//       onTap: () {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text("$title page coming soon...")));
//       },

//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,

//         children: [
//           Container(
//             padding: const EdgeInsets.all(14),

//             decoration: BoxDecoration(
//               color: primaryColor.withOpacity(.1),
//               shape: BoxShape.circle,
//             ),

//             child: Icon(icon, size: 32, color: primaryColor),
//           ),

//           const SizedBox(height: 12),

//           Text(
//             title,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     ),
//   );
// }
