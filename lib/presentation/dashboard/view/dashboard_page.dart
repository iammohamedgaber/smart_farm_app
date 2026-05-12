// import 'package:flutter/material.dart';
// import 'package:smart_farm_app/presentation/dashboard/widgets/dashboard_card.dart';

// class DashboardPage extends StatelessWidget {
//   const DashboardPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Smart Farm Dashboard"),
//         backgroundColor: primaryColor,
//         elevation: 0,
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(16),

//         child: GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16,
//           mainAxisSpacing: 16,

//           children: [
//             CardDashboard(context, "Zones", Icons.grass),

//             CardDashboard(context, "Operations", Icons.agriculture),

//             CardDashboard(context, "Crops", Icons.eco),

//             CardDashboard(context, "Robots", Icons.smart_toy),

//             CardDashboard(context, "Profile", Icons.person),
//           ],
//         ),
//       ),
//     );
//   }
// }
